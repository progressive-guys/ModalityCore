import Foundation
import ModalityCore
import Testing

struct TreeTests {
  @Test func mapKeepsFoldersAndLeafOrder() throws {
    let tree = try fixture()
    let mapped = tree.map { "value:\($0)" }

    #expect(mapped.flattened == ["value:3", "value:7"])
    guard case .folder(let title, let children) = mapped.node else {
      Issue.record("Expected a folder")
      return
    }
    #expect(title == "Catalog")
    let folders = children.compactMap { child -> String? in
      guard case .folder(let title, _) = child.node else { return nil }
      return title
    }
    #expect(folders == ["Nested", "Empty"])
    #expect(children.last?.children?.isEmpty == true)
  }

  @Test func mapPropagatesLeafError() throws {
    enum Failure: Error { case rejected }
    let tree = try fixture()
    #expect(throws: Failure.self) {
      try tree.map { value -> Int in
        if value == 7 { throw Failure.rejected }
        return value
      }
    }
  }

  @Test func valueNeedsNoProtocols() {
    final class Value {}
    let value = Value()
    let tree = Tree(value)
    #expect(tree.value === value)
    #expect(tree.map { $0 === value }.value == true)
  }

  private func fixture() throws -> Tree<Int> {
    #if SWIFT_PACKAGE
    let bundle = Bundle.module
    #else
    let bundle = Bundle(for: BundleToken.self)
    #endif
    let url = try #require(bundle.url(forResource: "tree", withExtension: "json"))
    return try JSONDecoder().decode(Fixture.self, from: Data(contentsOf: url)).tree
  }

  private final class BundleToken {}

  private struct Fixture: Decodable {
    let title: String?
    let value: Int?
    let children: [Fixture]?

    var tree: Tree<Int> {
      get throws {
        if let value { return Tree(value) }
        let title = try #require(title)
        let children = try #require(children)
        return Tree(folder: title, children: try children.map { try $0.tree })
      }
    }
  }
}
