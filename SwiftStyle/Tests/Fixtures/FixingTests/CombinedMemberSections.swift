// MARK: - Input
final class Example {

  // Commands.
  private func longerName() -> Int { observed }
  public func a() -> String { "value" }

  // Values.
  var longerValue: String { "value" }
  var x: Int { observed }

  // Other values.
  static var flag: Bool { true }

  init() {}

  var observed = 0 { didSet {} }
}

protocol Requirements {

  func longerName()

  // Other commands.
  func a()

  var writable: String { get set }
  var x: Int { get }

  init()
}

extension Example {

  func longerExtension() -> Int { x }

  // Other commands.
  func b() {}

  var extendedValue: String { "value" }
  var y: Int { x }
}

// MARK: - Output
final class Example {

  var observed = 0 { didSet {} }

  init() {}

  // Values.
  var longerValue: String { "value" }
  var x: Int { observed }

  // Other values.
  static var flag: Bool { true }

  // Commands.
  private func longerName() -> Int { observed }
  public func a() -> String { "value" }
}

protocol Requirements {

  init()

  var writable: String { get set }
  var x: Int { get }

  func longerName()

  // Other commands.
  func a()
}

extension Example {

  var extendedValue: String { "value" }
  var y: Int { x }

  func longerExtension() -> Int { x }

  // Other commands.
  func b() {}
}
