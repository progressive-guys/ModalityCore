import Foundation
import ModalityCore
import Testing

struct FileResourceTests {
  @Test(arguments: [
    ("Seventh Chords Arpeggios 2 Tests.xml", "Seventh Chords Arpeggios 2 Tests", "xml"),
    ("profile.default.json", "profile.default", "json"),
    ("The Spiders Revenge 🕷️.xml", "The Spiders Revenge 🕷️", "xml"),
    ("LICENSE", "LICENSE", "")
  ])
  func fileNameComponents(fileName: String, name: String, ext: String) {
    let resource = FileResource<Data>(fileName, bundle: .main)

    #expect(resource.name == name)
    #expect(resource.ext == ext)
  }

  @Test
  func missingResourceReportsFileName() {
    let resource = FileResource<Data>("missing-\(UUID().uuidString).json", bundle: .main)

    do {
      _ = try resource.url
      Issue.record("Expected a missing resource error")
    } catch {
      let error = error as NSError
      #expect(error.domain == NSCocoaErrorDomain)
      #expect(error.code == CocoaError.fileReadNoSuchFile.rawValue)
      #expect(error.userInfo[NSFilePathErrorKey] as? String == resource.fileName)
    }
  }
}
