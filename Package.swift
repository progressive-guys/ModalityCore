// swift-tools-version: 5.9
import PackageDescription

let package = Package(
  name: "ModalityCore",
  platforms: [.iOS(.v16), .macOS(.v13), .visionOS(.v1)],
  products: [
    .library(name: "ModalityCore", targets: ["ModalityCore"]),
    .library(name: "ModalityDesign", targets: ["ModalityDesign"]),
  ],
  dependencies: [
    .package(url: "https://github.com/modality-lab/SwiftMusicTheory.git", branch: "main"),
  ],
  targets: [
    .target(
      name: "ModalityCore",
      dependencies: ["SwiftMusicTheory"],
      path: "ModalityCore",
      sources: ["Sources"]
    ),
    .target(
      name: "ModalityDesign",
      dependencies: ["ModalityCore", "SwiftMusicTheory"],
      path: "ModalityDesign",
      sources: ["Sources"],
      resources: [.process("Resources")]
    ),
    .testTarget(
      name: "ModalityCoreUnitTests",
      dependencies: ["ModalityCore"],
      path: "UnitTests/ModalityCore",
      resources: [.process("TreeTests/Resources"), .copy("FileSystemStoreTests/Resources")]
    ),
    .testTarget(
      name: "ModalityDesignUnitTests",
      dependencies: ["ModalityDesign"],
      path: "UnitTests/ModalityDesign"
    ),
  ]
)
