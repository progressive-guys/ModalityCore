// MARK: - Input
enum Examples {
  protocol Named { var name: String { get } }

  class Animal {}

  final class Bird: Animal, Named { let name = "bird" }

  final class Fish: Animal {}

  static func classChecks(_ input: Animal) -> Int {
    if input is Bird { return 1 }
    if input is Fish { return 2 }
    if input is any Named { return 3 }
    return 0
  }

  static func mixedChecks(_ input: Any) -> Int {
    if let item = input as? Bird { return item.name.count }
    if input is Fish { return 2 }
    if let item = input as? any Named { return item.name.count }
    return 0
  }

  static func genericTypes(_ input: Any) -> Int {
    if let item = input as? [Swift.String] { return item.count }
    if let item = input as? Dictionary<String, Int> { return item.count }
    if let item = input as? Set<Int> { return item.count }
    return 0
  }
}

// MARK: - Output
enum Examples {

  protocol Named {
    var name: String { get } }

  class Animal {}

  final class Bird: Animal, Named {
    let name = "bird" }

  final class Fish: Animal {}

  static func classChecks(_ input: Animal) -> Int {
    switch (input) {
    case is Bird:
      return 1

    default:
      break
    }

    switch (input) {
    case is Fish:
      return 2

    default:
      break
    }

    switch (input) {
    case is any Named:
      return 3

    default:
      break
    }

    return 0
  }

  static func mixedChecks(_ input: Any) -> Int {
    switch (input) {
    case let item as Bird:
      return item.name.count

    default:
      break
    }

    switch (input) {
    case is Fish:
      return 2

    default:
      break
    }

    switch (input) {
    case let item as any Named:
      return item.name.count

    default:
      break
    }

    return 0
  }

  static func genericTypes(_ input: Any) -> Int {
    switch (input) {
    case let item as [Swift.String]:
      return item.count

    default:
      break
    }

    switch (input) {
    case let item as Dictionary<String, Int>:
      return item.count

    default:
      break
    }

    switch (input) {
    case let item as Set<Int>:
      return item.count

    default:
      break
    }

    return 0
  }
}
