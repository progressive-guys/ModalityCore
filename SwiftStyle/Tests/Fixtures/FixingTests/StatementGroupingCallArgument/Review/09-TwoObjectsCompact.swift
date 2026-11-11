// MARK: - Input
final class Node {

  var first = 0
  var second = 0

  func apply(_ value: Int) {}
  func render() {}
  func touch() {}
}

enum Example {

  static func run(input: Int) {
    let first = Node()
    first.first = input
    first.render()
    let second = Node()
    second.first = input
    second.render()
  }
}

// MARK: - Output
final class Node {

  var first = 0
  var second = 0

  func apply(_ value: Int) {}
  func render() {}
  func touch() {}
}

enum Example {

  static func run(input: Int) {
    let first = Node()
    first.first = input
    first.render()

    let second = Node()
    second.first = input
    second.render()
  }
}
