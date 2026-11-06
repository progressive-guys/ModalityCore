// MARK: - Input
final class Sections {

  func delayed() async {}
  var computed: Int { value }
  subscript(index: Int) -> Int { index }
  deinit {}
  init() {}
  var value = 0
  // Nested types.
  struct LongerName {}
  enum Mode {}
  final class Child {}
  actor Worker {}
  protocol Requirement {}
  // Aliases.
  typealias LongName = Int
  typealias A = LongName
  func plain() {}
}

protocol Requirements {

  func read()
  subscript(index: Int) -> Int { get }
  associatedtype Value
  typealias Number = Int
}

extension Sections {

  func extended() {}
  struct Extra {}
  typealias Result = Int
}

final class ConditionalSections {

  func read() {}
  #if os(macOS)
  subscript(index: Int) -> Int { index }
  #else
  subscript(index: Int) -> Int { index + 1 }
  #endif
  #if os(macOS)
  struct Value {}
  #else
  struct Value {}
  #endif

  var stored = 0
  init() {}
  deinit {}
}

// MARK: - Output
final class Sections {

  // Aliases.
  typealias LongName = Int

  typealias A = LongName

  // Nested types.
  struct LongerName {}

  enum Mode {}

  final class Child {}

  actor Worker {}

  protocol Requirement {}

  var value = 0

  init() {}

  deinit {}

  subscript(index: Int) -> Int { index }

  var computed: Int { value }

  func plain() {}

  func delayed() async {}
}

protocol Requirements {

  typealias Number = Int

  associatedtype Value

  subscript(index: Int) -> Int { get }

  func read()
}

extension Sections {
  typealias Result = Int

  struct Extra {}

  func extended() {}
}

final class ConditionalSections {

  #if os(macOS)
  struct Value {}
  #else
  struct Value {}
  #endif

  var stored = 0

  init() {}

  deinit {}
  #if os(macOS)
  subscript(index: Int) -> Int { index }
  #else
  subscript(index: Int) -> Int { index + 1 }
  #endif

  func read() {}
}
