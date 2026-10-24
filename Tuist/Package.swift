// swift-tools-version: 6.0
import PackageDescription

#if TUIST
import ProjectDescription
let useLocalProjects = !Environment.localProjectsRoot.getString(default: "").isEmpty
let packageSettings = PackageSettings(productTypes: [
  "SwiftMusicTheory": .framework,
  "ModalityCore": .framework,
  "ModalityDesign": .framework
])
#else
let useLocalProjects = false
#endif

let package = Package(
  name: "ModalityCore",
  dependencies: useLocalProjects ? [] : [
    .package(url: "https://github.com/modality-lab/SwiftMusicTheory.git", from: "1.0.0"),
  ]
)
