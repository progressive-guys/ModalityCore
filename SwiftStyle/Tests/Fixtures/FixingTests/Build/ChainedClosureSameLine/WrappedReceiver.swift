// MARK: - Input
import Foundation

enum Library {

  static func files(in folder: URL) throws -> [URL] {
    try FileManager.default.contentsOfDirectory(
      at: folder,
      includingPropertiesForKeys: [.isDirectoryKey],
      options: .skipsHiddenFiles
    )
      .flatMap { url in
        url.pathExtension == "xml" ? [url] : []
      }
  }
}

// MARK: - Output
import Foundation

enum Library {

  static func files(in folder: URL) throws -> [URL] {
    try FileManager.default.contentsOfDirectory(
      at: folder,
      includingPropertiesForKeys: [.isDirectoryKey],
      options: .skipsHiddenFiles
    ).flatMap { url in
        url.pathExtension == "xml" ? [url] : []
      }
  }
}
