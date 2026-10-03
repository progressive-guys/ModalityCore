import Foundation

public extension JSONDecoder {
  /// Fills missing or null top-level JSON fields from the supplied value.
  func decode<T: Codable>(from data: Data, defaultValue: T) throws -> T {
    let defaultData = try JSONEncoder().encode(defaultValue)
    var mergedData = data
    if var fields = try JSONSerialization.jsonObject(with: defaultData, options: .fragmentsAllowed) as? [String: Any],
       let savedFields = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] {
      fields.merge(savedFields.filter { !($0.value is NSNull) }) { _, saved in saved }
      mergedData = try JSONSerialization.data(withJSONObject: fields)
    }
    return try decode(T.self, from: mergedData)
  }
}
