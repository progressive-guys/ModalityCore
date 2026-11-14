// MARK: - Case BreakBeforeChainedClosure
// MARK: Input
enum Examples {
  static func value(_ values: [Int]) -> [Int] {
    values.map { $0 + 1 }.filter { value in
      value > 0
    }
  }
}

// MARK: Output
enum Examples {

  static func value(_ values: [Int]) -> [Int] {
    values.map { $0 + 1 }
      .filter { value in
      value > 0
    }
  }
}

// MARK: - Case ClosureSuffixJoinsWrappedReceiver
// MARK: Input
import Foundation

enum Library {

  static func files(in folder: URL) throws -> [URL] {
    try FileManager.default.contentsOfDirectory(
      at: folder,
      includingPropertiesForKeys: [.isDirectoryKey],
      options: .skipsHiddenFiles
    )
      .flatMap { url in
        url.pathExtension == "xml" ? [url] : []
      }
  }
}

// MARK: Output
import Foundation

enum Library {

  static func files(in folder: URL) throws -> [URL] {
    try FileManager.default.contentsOfDirectory(
      at: folder,
      includingPropertiesForKeys: [.isDirectoryKey],
      options: .skipsHiddenFiles
    ).flatMap { url in
        url.pathExtension == "xml" ? [url] : []
      }
  }
}

// MARK: - Case ExpandChainedCallArguments
// MARK: Input
enum Examples {
  static func value(_ values: [Int], _ value: Int) -> Bool {
    values.sorted().contains(
      value
    )
  }
}

// MARK: Output
enum Examples {

  static func value(_ values: [Int], _ value: Int) -> Bool {
    values.sorted()
      .contains(
      value
    )
  }
}

// MARK: - Case JoinReturnCallWithClosure
// MARK: Input
enum Examples {
  static func values() -> [Int] {
    let text = String(
      repeating: "a",
      count: 2
    )

    let count = text.count

    return Array(
      repeating: count,
      count: 2
    )
      .map { value in
        value + 1
      }
  }
}

// MARK: Output
enum Examples {
  static func values() -> [Int] {
    let text = String(
      repeating: "a",
      count: 2
    )

    let count = text.count

    return Array(
      repeating: count,
      count: 2
    ).map { value in
        value + 1
      }
  }
}

// MARK: - Case PartlyWrappedMemberChain
// MARK: Input
enum Examples {
  static func value(_ values: [Int]) -> Int {
    values.sorted().dropFirst()
      .count
  }
}

// MARK: Output
enum Examples {

  static func value(_ values: [Int]) -> Int {
    values.sorted()
      .dropFirst()
      .count
  }
}

// MARK: - Case SuffixArgumentsJoinWrappedReceiver
// MARK: Input
enum Examples {

  static func values() -> [Int] {
    Array(
      repeating: 1,
      count: 2
    )
      .reduce(
        into: []
      ) { values, value in
        values.append(value)
      }
  }
}

// MARK: Output
enum Examples {

  static func values() -> [Int] {
    Array(
      repeating: 1,
      count: 2
    ).reduce(
        into: []
      ) { values, value in
        values.append(value)
      }
  }
}
