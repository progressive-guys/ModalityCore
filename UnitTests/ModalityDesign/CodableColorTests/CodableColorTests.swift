import Foundation
import SwiftUI
import Testing
import ModalityDesign

struct CodableColorTests {
  private struct Profile: Codable {
    @CodableColor var color: Color = .primary
  }

  @Test(arguments: [Color.primary, .white])
  func semanticColorsKeepTheirIdentity(_ color: Color) throws {
    let profile = Profile(color: color)

    let restored = try JSONDecoder().decode(Profile.self, from: JSONEncoder().encode(profile))

    #expect(restored.color == color)
  }

  @Test
  func customColorKeepsItsComponents() throws {
    var profile = Profile()
    profile.color = Color(.sRGB, red: 0.17, green: 0.42, blue: 0.85, opacity: 0.65)

    let restored = try JSONDecoder().decode(Profile.self, from: JSONEncoder().encode(profile))
    let expected = profile.color.components
    let actual = restored.color.components

    #expect(abs(actual.red - expected.red) < 0.000001)
    #expect(abs(actual.green - expected.green) < 0.000001)
    #expect(abs(actual.blue - expected.blue) < 0.000001)
    #expect(abs(actual.alpha - expected.alpha) < 0.000001)
  }

  @Test
  func previousColorFormatIsAccepted() throws {
    let data = Data(#"{"color":{"rgba":{"red":0.25,"green":0.5,"blue":0.75,"alpha":1}}}"#.utf8)

    let restored = try JSONDecoder().decode(Profile.self, from: data)

    #expect(restored.color == Color(.sRGB, red: 0.25, green: 0.5, blue: 0.75))
  }
}
