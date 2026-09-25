public struct Tree<Value> {

  public enum Node {
    case folder(title: String, children: [Tree<Value>])
    case leaf(Value)
  }

  public let node: Node

  public init(folder title: String, children: [Tree<Value>] = []) {
    self.node = .folder(title: title, children: children)
  }

  public init(_ value: Value) {
    self.node = .leaf(value)
  }

  public var children: [Tree<Value>]? {
    switch node {
    case .folder(_, let children):
      return children
    case .leaf:
      return nil
    }
  }

  public var value: Value? {
    switch node {
    case .folder:
      return nil
    case .leaf(let value):
      return value
    }
  }

  public var flattened: [Value] {
    switch node {
    case .folder(_, let children):
      return children.flatMap { $0.flattened }
    case .leaf(let value):
      return [value]
    }
  }

  public func map<Mapped>(_ transform: (Value) throws -> Mapped) rethrows -> Tree<Mapped> {
    switch node {
    case .folder(let title, let children):
      return Tree<Mapped>(folder: title, children: try children.map { try $0.map(transform) })
    case .leaf(let value):
      return Tree<Mapped>(try transform(value))
    }
  }
}

extension Tree: Sendable where Value: Sendable {}
extension Tree.Node: Sendable where Value: Sendable {}
extension Tree: Equatable where Value: Equatable {}
extension Tree.Node: Equatable where Value: Equatable {}
extension Tree: Hashable where Value: Hashable {}
extension Tree.Node: Hashable where Value: Hashable {}

extension Tree: Identifiable where Value: Identifiable {
  public var id: String { node.id }
}

extension Tree.Node: Identifiable where Value: Identifiable {
  public var id: String {
    switch self {
    case .folder(let title, _): return "folder_\(title)"
    case .leaf(let value): return "leaf_\(value.id)"
    }
  }
}
