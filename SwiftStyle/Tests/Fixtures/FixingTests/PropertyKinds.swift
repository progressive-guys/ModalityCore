// MARK: - Input
class Example {
  private var longerName: Int = 1
  public let x = 2
  var y = "text"
}

// MARK: - Output
class Example {
  public let x = 2

  var y = "text"
  private var longerName: Int = 1
}
