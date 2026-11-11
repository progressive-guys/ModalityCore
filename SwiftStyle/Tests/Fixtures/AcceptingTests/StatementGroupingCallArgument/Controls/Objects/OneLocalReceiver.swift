final class Node {

  var first = 0
  var second = 0

  func apply(_ value: Int) {}
  func render() {}
  func touch() {}
}

enum Example {

  static func run(input: Int, other: Int) {
    let node = Node()
    node.first = input
    node.second = other
    node.apply(input)
    node.render()
  }
}
