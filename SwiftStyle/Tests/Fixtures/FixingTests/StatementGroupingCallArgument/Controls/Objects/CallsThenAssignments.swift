// MARK: - Input
final class Node {

  var first = 0
  var second = 0

  func apply(_ value: Int) {}
  func render() {}
  func touch() {}
}

enum Example {

  static func run(node: Node) {
    node.touch()
    node.render()
    node.first = 1
    node.second = 2
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

  static func run(node: Node) {
    node.touch()
    node.render()

    node.first = 1
    node.second = 2
  }
}
