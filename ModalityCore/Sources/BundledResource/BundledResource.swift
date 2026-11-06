import Foundation

public struct BundledResource<Content>: Hashable, Sendable {

  public let path: String
  private let bundle: Bundle

  public init(_ path: String, bundle: Bundle) {
    self.path = path
    self.bundle = bundle
  }

  public var ext: String { (fileName as NSString).pathExtension }
  public var fileName: String { (path as NSString).lastPathComponent }
  public var name: String { (fileName as NSString).deletingPathExtension }

  public var url: URL {
    get throws {
      guard let url = bundle.url(
        forResource: fileName,
        withExtension: nil,
        subdirectory: (path as NSString).deletingLastPathComponent.isEmpty
        ? nil
        : (path as NSString).deletingLastPathComponent
      ) ?? bundle.url(forResource: fileName, withExtension: nil)
      else { throw CocoaError(.fileReadNoSuchFile, userInfo: [NSFilePathErrorKey: fileName]) }
      return url
    }
  }

  /// Lists files below a bundle directory in path order.
  public static func files(in directory: String, bundle: Bundle, extension ext: String) throws -> [Self] {
    guard let resourceURL = bundle.resourceURL else { throw CocoaError(.fileReadNoSuchFile) }
    let root = resourceURL.resolvingSymlinksInPath()
    let folder = root.appendingPathComponent(directory)

    let manager = FileManager.default

    func collect(_ folder: URL) throws -> [URL] {
      try manager.contentsOfDirectory(
        at: folder,
        includingPropertiesForKeys: [.isDirectoryKey],
        options: .skipsHiddenFiles
      )
        .flatMap { url in
          if try url.resourceValues(forKeys: [.isDirectoryKey]).isDirectory == true {
            return try collect(url)
          }

          return url.pathExtension == ext ? [url] : []
        }
    }

    return try collect(folder).sorted { $0.path < $1.path }.map {
      Self(String($0.resolvingSymlinksInPath().path.dropFirst(root.path.count + 1)), bundle: bundle)
    }
  }

}
