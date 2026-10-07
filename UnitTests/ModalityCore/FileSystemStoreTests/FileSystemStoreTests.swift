import Foundation
import ModalityCore
import Testing

struct FileSystemStoreTests {
  @Test func savesAndReplacesAtTheSameURL() throws {
    let directory = temporaryDirectory()
    defer { trashTemporaryDirectory(directory) }
    let url = directory.appendingPathComponent("nested/profile.json")
    let store = FileSystemStore<Profile>()
    var profile = try store.read(from: fixture("storeProfile"))

    let saved = try store.save(profile, to: url)
    #expect(saved.url == url)
    #expect(try store.read(from: url) == profile)

    profile.name = "Edited"
    try store.save(profile, to: url)
    #expect(try store.read(from: url).name == "Edited")
    #expect(try store.readDirectory(at: url.deletingLastPathComponent()).trees.flatMap(\.flattened).count == 1)
  }

  @Test func directoryReportsBadFilesAndKeepsGoodRecords() throws {
    let directory = temporaryDirectory()
    defer { trashTemporaryDirectory(directory) }
    try FileManager.default.createDirectory(at: directory.appendingPathComponent("subfolder"), withIntermediateDirectories: true)
    let validURL = directory.appendingPathComponent("valid.json")
    let invalidURL = directory.appendingPathComponent("invalid.json")
    try FileManager.default.copyItem(at: fixture("storeProfile"), to: validURL)
    try FileManager.default.copyItem(at: fixture("storeInvalid"), to: invalidURL)

    let result = try FileSystemStore<Profile>().readDirectory(at: directory)

    #expect(result.trees.flatMap(\.flattened).map { $0.url.resolvingSymlinksInPath() } == [validURL.resolvingSymlinksInPath()])
    #expect(result.trees.flatMap(\.flattened).first?.value.name == "Practice")
    #expect(Set(result.errors.keys) == [invalidURL.standardizedFileURL])
  }

  @Test func missingDirectoryIsEmptyWithoutCreatingIt() throws {
    let directory = temporaryDirectory()
    let result = try FileSystemStore<Profile>().readDirectory(at: directory)
    #expect(result.trees.isEmpty)
    #expect(result.errors.isEmpty)
    #expect(!FileManager.default.fileExists(atPath: directory.path))
    #expect(throws: (any Error).self) {
      try FileSystemStore<Profile>().read(from: directory.appendingPathComponent("missing.json"))
    }
  }

  @Test func directoryKeepsNestedAndEmptyFolders() throws {
    let directory = temporaryDirectory()
    defer { trashTemporaryDirectory(directory) }
    try prepareDirectory(at: directory)

    let result = try FileSystemStore<Profile>().readDirectory(at: directory)

    #expect(result.trees.map(nodeName).sorted() == ["Empty", "Nested", "root.json"])
    let empty = try folder("Empty", in: result.trees)
    #expect(empty.isEmpty)
    let nested = try folder("Nested", in: result.trees)
    #expect(nested.map(nodeName).sorted() == ["Deep", "Empty"])
    #expect(try folder("Empty", in: nested).isEmpty)
    #expect(try folder("Deep", in: nested).map(nodeName) == ["profile.json"])

    let entries = result.trees.flatMap(\.flattened)
    let expectedURLs = ["Nested/Deep/profile.json", "root.json"].map {
      directory.appendingPathComponent($0).resolvingSymlinksInPath()
    }
    #expect(entries.count == expectedURLs.count)
    #expect(Set(entries.map { $0.url.resolvingSymlinksInPath() }) == Set(expectedURLs))
    #expect(entries.map(\.value.name) == ["Practice", "Practice"])
    #expect(Set(result.errors.keys) == [directory.appendingPathComponent("Nested/broken.json").standardizedFileURL])
  }

  @Test func fileCannotBeReadAsDirectory() throws {
    #expect(throws: CocoaError.self) {
      try FileSystemStore<Profile>().readDirectory(at: fixture("storeProfile"))
    }
  }

  @Test func failedEncodingKeepsPreviousFile() throws {
    let directory = temporaryDirectory()
    defer { trashTemporaryDirectory(directory) }
    let url = directory.appendingPathComponent("number.json")
    let store = FileSystemStore<Double>()
    let original = 0.75
    try store.save(original, to: url)

    #expect(throws: EncodingError.self) { try store.save(.nan, to: url) }
    #expect(try store.read(from: url) == original)
  }

  @Test func ownerCanSupplyProfileDefaults() throws {
    let store = FileSystemStore<Profile> {
      try JSONDecoder().decode(from: $0, defaultValue: Profile(name: "Default", speed: 1))
    }
    let profile = try store.read(from: fixture("storePartialProfile"))
    #expect(profile.name == "Imported")
    #expect(profile.speed == 1)
    #expect(throws: DecodingError.self) {
      try FileSystemStore<Profile>().read(from: fixture("storePartialProfile"))
    }
  }

  @Test func deletionRemovesEntryFromTheActiveDirectory() throws {
    let directory = temporaryDirectory()
    defer { trashTemporaryDirectory(directory) }
    let url = directory.appendingPathComponent("profile.json")
    let store = FileSystemStore<Profile>()
    let profile = try store.read(from: fixture("storeProfile"))
    try store.save(profile, to: url)

    try store.delete(at: url)

    #expect(!FileManager.default.fileExists(atPath: url.path))
    let result = try store.readDirectory(at: directory)
    #expect(result.trees.isEmpty)
    #expect(result.errors.isEmpty)
  }

  private struct Profile: Codable, Equatable, Sendable {
    var name: String
    var speed: Double
  }

  private func fixture(_ name: String, withExtension ext: String? = "json") throws -> URL {
    #if SWIFT_PACKAGE
    let bundle = Bundle.module
    #else
    let bundle = Bundle(for: BundleToken.self)
    #endif
    return try #require(bundle.url(forResource: name, withExtension: ext, subdirectory: "Resources"))
  }

  private func prepareDirectory(at directory: URL) throws {
    try FileManager.default.copyItem(at: fixture("StoreDirectory", withExtension: nil), to: directory)
    // Create links in the temporary copy so resource packaging does not follow the cycle.
    try FileManager.default.createSymbolicLink(atPath: directory.appendingPathComponent("Nested/loop").path, withDestinationPath: "..")
    try FileManager.default.createSymbolicLink(
      atPath: directory.appendingPathComponent("linked.json").path,
      withDestinationPath: "root.json"
    )
  }

  private func nodeName(_ tree: Tree<FileSystemStore<Profile>.Entry>) -> String {
    switch tree.node {
    case .folder(let title, _): title
    case .leaf(let entry): entry.url.lastPathComponent
    }
  }

  private func folder(_ title: String, in trees: [Tree<FileSystemStore<Profile>.Entry>]) throws -> [Tree<FileSystemStore<Profile>.Entry>] {
    let tree = try #require(trees.first {
      guard case .folder(let name, _) = $0.node else { return false }
      return name == title
    })
    return try #require(tree.children)
  }

  private final class BundleToken {}

  private func temporaryDirectory() -> URL {
    FileManager.default.temporaryDirectory.appendingPathComponent("FileSystemStoreTests-\(UUID().uuidString)")
  }

  private func trashTemporaryDirectory(_ directory: URL) {
    #if os(macOS)
    try? FileManager.default.trashItem(at: directory, resultingItemURL: nil)
    #endif
  }
}
