import Foundation

/// Synchronous file operations. Call from a worker task when used by a UI owner.
public struct FileSystemStore<Value: Codable & Sendable>: Sendable {
  public struct Entry: Sendable {
    public let value: Value
    public let url: URL
  }

  private let decode: @Sendable (Data) throws -> Value

  public init(decode: @escaping @Sendable (Data) throws -> Value = { try JSONDecoder().decode(Value.self, from: $0) }) {
    self.decode = decode
  }

  public func read(from url: URL) throws -> Value {
    try decode(Data(contentsOf: url))
  }

  public func readDirectory(at directory: URL) throws -> (trees: [Tree<Entry>], errors: [URL: any Error]) {
    var errors: [URL: any Error] = [:]
    do {
      let trees = try readTrees(at: directory, errors: &errors)
      return (trees, errors)
    } catch let error as CocoaError where error.code == .fileReadNoSuchFile {
      return ([], [:])
    }
  }

  @discardableResult
  public func save(_ value: Value, to url: URL) throws -> Entry {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
    let data = try encoder.encode(value)
    try FileManager.default.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
    try data.write(to: url, options: .atomic)
    return Entry(value: value, url: url)
  }

  public func delete(at url: URL) throws {
    try FileManager.default.removeItem(at: url)
  }

  private func readTrees(at directory: URL, errors: inout [URL: any Error]) throws -> [Tree<Entry>] {
    let keys: Set<URLResourceKey> = [.isDirectoryKey, .isRegularFileKey, .isSymbolicLinkKey]
    let urls = try FileManager.default.contentsOfDirectory(
      at: directory,
      includingPropertiesForKeys: Array(keys),
      options: [.skipsHiddenFiles]
    )
    var trees: [Tree<Entry>] = []
    for url in urls {
      do {
        let attributes = try url.resourceValues(forKeys: keys)
        // Follow real directories only, so links cannot introduce cycles or leave the catalog.
        guard attributes.isSymbolicLink != true else { continue }
        if attributes.isDirectory == true {
          let children = try readTrees(at: url, errors: &errors)
          trees.append(Tree(folder: url.lastPathComponent, children: children))
        } else if attributes.isRegularFile == true {
          trees.append(Tree(Entry(value: try read(from: url), url: url)))
        }
      } catch {
        errors[url.standardizedFileURL] = error
      }
    }
    return trees
  }
}
