import Foundation
import os

public extension UserDefaults {
  func set<C: Encodable>(codable: C, forKey key: String) {
    do {
      let encoded = try JSONEncoder().encode(codable)
      set(encoded, forKey: key)
    } catch {
      Logger.userDefaults.error("EncodeError \(error)")
    }
  }

  func decode<T: Decodable>(_ type: T.Type = T.self, forKey key: String) -> T? {
    if let savedData = object(forKey: key) {

      do {
        guard let data = savedData as? Data else { return nil }
        let decoded = try JSONDecoder().decode(type, from: data)
        return decoded
      } catch {
        Logger.userDefaults.error("DecodeError \(error)")
        return nil
      }
    } else {
      return nil
    }
  }

  /// Fills missing or null top-level JSON fields from the supplied value.
  func decode<T: Codable>(forKey key: String, defaultValue: T) -> T {
    guard let savedData = data(forKey: key) else { return defaultValue }
    do {
      let defaultData = try JSONEncoder().encode(defaultValue)
      var data = savedData
      if var fields = try JSONSerialization.jsonObject(with: defaultData, options: .fragmentsAllowed) as? [String: Any],
         let savedFields = try JSONSerialization.jsonObject(with: savedData, options: .fragmentsAllowed) as? [String: Any] {
        fields.merge(savedFields.filter { !($0.value is NSNull) }) { _, saved in saved }
        data = try JSONSerialization.data(withJSONObject: fields)
      }
      return try JSONDecoder().decode(T.self, from: data)
    } catch {
      Logger.userDefaults.error("DecodeError \(error)")
      return defaultValue
    }
  }
}

public extension Logger {
  static let userDefaults = Logger(category: "UserDefaults")
}
