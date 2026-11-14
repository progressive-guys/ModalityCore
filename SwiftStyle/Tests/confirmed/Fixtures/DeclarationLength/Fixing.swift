// MARK: - Case DeclarationLengthNotNameLength
// MARK: Input
enum Windows {
  static let a = "a substantially longer literal"
  static let longerName = "x"
}

// MARK: Output
enum Windows {

  static let longerName = "x"
  static let a = "a substantially longer literal"
}

// MARK: - Case ProtocolMethodRequirements
// MARK: Input
private protocol Actions {
  func value(for index: Int) -> Int
  func reset()
}

// MARK: Output
private protocol Actions {

  func reset()
  func value(for index: Int) -> Int
}

// MARK: - Case ProtocolRequirements
// MARK: Input
private protocol Values {
  var longerName: Int { get }
  var x: Int { get }
}

// MARK: Output
private protocol Values {

  var x: Int { get }
  var longerName: Int { get }
}
