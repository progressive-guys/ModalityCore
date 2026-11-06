// MARK: - Input
import Foundation

enum Examples {
  static func directoryEntries(_ entries: [URL]) throws {
    var projects: [URL] = []

    for entry in entries {
      let values = try entry.resourceValues(forKeys: [.isDirectoryKey, .isSymbolicLinkKey])

      guard values.isDirectory == true, values.isSymbolicLink != true else { continue }
      projects.append(entry)
    }
  }

  static func fourCodeLines(_ input: Int) {
    let value = input

    guard value > 0 else { return }
    print(value)
    print(input)
  }

  static func fiveCodeLines(_ input: Int) {
    let value = input
    guard value > 0 else { return }
    print(value)
    print(input)
    print("done")
  }

  static func gapBeforeRelatedIf(_ input: Int) {
    let value = input

    if value > 0 { print(value) }

    print(value)
    print(input)
  }

  static func multilineCheck(_ input: Int) {
    let value = input

    guard value > 0 else {
      return
    }
  }

  static func multilineBinding(_ input: Int) {
    let value = max(
      input, 0
    )

    if value == 0 { print(value) }
  }

  static func shorthandBinding(_ input: Int?) {
    let value = input

    guard let value else { return }

    print(value)
    print("done")
  }

  static func explicitBinding(_ input: Int?) {
    let candidate = input

    if let value = candidate, value > 0 { print(value) }

    print(candidate as Any)
    print("done")
  }

  static func matchingPattern(_ input: Int?) {
    let value = input

    guard case .some(let number) = value, number > 0 else { return }

    print(value as Any)
    print("done")
  }
}

// MARK: - Output
import Foundation

enum Examples {

  static func fourCodeLines(_ input: Int) {
    let value = input
    guard value > 0 else { return }
    print(value)
    print(input)
  }

  static func fiveCodeLines(_ input: Int) {
    let value = input
    guard value > 0 else { return }
    print(value)
    print(input)
    print("done")
  }

  static func gapBeforeRelatedIf(_ input: Int) {
    let value = input
    if value > 0 {
      print(value)
    }
    print(value)
    print(input)
  }

  static func multilineCheck(_ input: Int) {
    let value = input
    guard value > 0 else { return }
  }

  static func multilineBinding(_ input: Int) {
    let value = max(
      input, 0
    )
    if value == 0 {
      print(value)
    }
  }

  static func shorthandBinding(_ input: Int?) {
    let value = input
    guard let value else { return }
    print(value)
    print("done")
  }

  static func explicitBinding(_ input: Int?) {
    let candidate = input
    if let value = candidate, value > 0 {
      print(value)
    }
    print(candidate as Any)
    print("done")
  }

  static func matchingPattern(_ input: Int?) {
    let value = input
    guard case .some(let number) = value, number > 0 else { return }
    print(value as Any)
    print("done")
  }

  static func directoryEntries(_ entries: [URL]) throws {
    var projects: [URL] = []
    for entry in entries {
      let values = try entry.resourceValues(forKeys: [.isDirectoryKey, .isSymbolicLinkKey])
      guard values.isDirectory == true, values.isSymbolicLink != true else { continue }
      projects.append(entry)
    }
  }
}
