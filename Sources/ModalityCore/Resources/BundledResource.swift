import Foundation

public struct BundledResource<Content>: Hashable, Sendable {
  public let fileName: String
  private let bundle: Bundle

  public init(_ fileName: String, bundle: Bundle) {
    self.fileName = fileName
    self.bundle = bundle
  }

  public var name: String { (fileName as NSString).deletingPathExtension }
  public var ext: String { (fileName as NSString).pathExtension }

  public var url: URL {
    get throws {
      guard let url = bundle.url(forResource: fileName, withExtension: nil) else {
        throw CocoaError(.fileReadNoSuchFile, userInfo: [NSFilePathErrorKey: fileName])
      }
      return url
    }
  }
}
