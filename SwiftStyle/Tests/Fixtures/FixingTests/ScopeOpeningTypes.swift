// MARK: - Input
enum Empty {

}

public enum ContentType: Hashable {

  case label
  case circularLabel
}

enum ThreeCases {

  // Labels.
  // Each name is a separate case.
  case first
  case second
  case third
}

enum FourCases {
  case first
  case second
  case third
  case fourth
}

struct ShortStruct {

  let value: Int
}

final class ShortClass {

  let value = 1
}

actor ShortActor {

  let value = 1
}

protocol ShortProtocol {

  var value: Int { get }
}

extension ShortStruct {

  func read() -> Int { value }
}

// MARK: - Output
enum Empty {
}

public enum ContentType: Hashable {
  case label
  case circularLabel
}

enum ThreeCases {
  // Labels.
  // Each name is a separate case.
  case first

  case second
  case third
}

enum FourCases {

  case first
  case second
  case third
  case fourth
}

struct ShortStruct {
  let value: Int
}

final class ShortClass {
  let value = 1
}

actor ShortActor {
  let value = 1
}

protocol ShortProtocol {
  var value: Int { get }
}

extension ShortStruct {
  func read() -> Int { value }
}
