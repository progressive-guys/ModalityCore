import Foundation
import Testing
import ModalityCore

struct UserDefaultsDecodingTests {
  private struct Settings: Codable, Equatable {
    var scale = 1.0
    var isVisible = true
  }

  @Test(arguments: [#"{"scale":2}"#, #"{"scale":2,"isVisible":null,"extra":1}"#])
  func missingFieldsUseSuppliedDefaults(_ json: String) throws {
    let fallback = Settings(scale: 3, isVisible: false)

    let result = try decode(json, defaultValue: fallback)

    #expect(result == Settings(scale: 2, isVisible: false))
  }

  @Test(arguments: ["invalid JSON", #"{"scale":"invalid"}"#])
  func invalidDataUsesSuppliedDefaults(_ json: String) throws {
    let fallback = Settings(scale: 3, isVisible: false)

    #expect(try decode(json, defaultValue: fallback) == fallback)
  }

  @Test
  func missingDataUsesSuppliedDefaults() throws {
    let fallback = Settings(scale: 3, isVisible: false)

    #expect(try decode(nil, defaultValue: fallback) == fallback)
  }

  @Test
  func scalarValuesAreDecoded() throws {
    #expect(try decode("2", defaultValue: 1) == 2)
  }

  private func decode<T: Codable>(_ json: String?, defaultValue: T) throws -> T {
    let suite = "UserDefaultsDecodingTests.\(UUID())"
    let defaults = try #require(UserDefaults(suiteName: suite))
    defer { defaults.removeObject(forKey: "settings") }
    if let json {
      defaults.set(Data(json.utf8), forKey: "settings")
    }
    return defaults.decode(forKey: "settings", defaultValue: defaultValue)
  }
}
