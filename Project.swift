import ProjectDescription
import ModalityBuild

let project = Project.linted(
  name: "ModalityCore",
  targets: [
    .target(
      name: "ModalityCore",
      destinations: [.iPhone, .iPad, .mac, .appleVision],
      product: .framework,
      bundleId: "com.modality.ModalityCore",
      infoPlist: .default,
      sources: ["ModalityCore/Sources/**"],
      dependencies: [.library("SwiftMusicTheory")],
      settings: .modalitySettings(release: ["ENABLE_TESTABILITY": "YES"])
    ),
    .target(
      name: "ModalityDesign",
      destinations: [.iPhone, .iPad, .mac, .appleVision],
      product: .framework,
      bundleId: "com.modality.ModalityDesign",
      infoPlist: .default,
      sources: ["ModalityDesign/Sources/**"],
      resources: ["ModalityDesign/Resources/**"],
      dependencies: [.target(name: "ModalityCore"), .library("SwiftMusicTheory")],
      settings: .modalitySettings(release: ["ENABLE_TESTABILITY": "YES"])
    ),
    .target(
      name: "ModalityCoreUnitTests",
      destinations: [.iPhone, .iPad, .mac, .appleVision],
      product: .unitTests,
      bundleId: "com.modality.ModalityCoreUnitTests",
      infoPlist: .default,
      sources: ["UnitTests/ModalityCore/**"],
      resources: ["UnitTests/ModalityCore/TreeTests/Resources/**", .folderReference(path: "UnitTests/ModalityCore/FileSystemStoreTests/Resources")],
      dependencies: [.target(name: "ModalityCore")],
      settings: .modalitySettings(base: ["MACOSX_DEPLOYMENT_TARGET": "14.0"])
    ),
    .target(
      name: "ModalityDesignUnitTests",
      destinations: [.iPhone, .iPad, .mac, .appleVision],
      product: .unitTests,
      bundleId: "com.modality.ModalityDesignUnitTests",
      infoPlist: .default,
      sources: ["UnitTests/ModalityDesign/**"],
      dependencies: [.target(name: "ModalityDesign")],
      settings: .modalitySettings(base: ["MACOSX_DEPLOYMENT_TARGET": "14.0"])
    ),
  ],
  lintPaths: [
    "ModalityCore": ["ModalityCore/Sources"],
    "ModalityDesign": ["ModalityDesign/Sources"],
    "ModalityCoreUnitTests": ["UnitTests/ModalityCore"],
    "ModalityDesignUnitTests": ["UnitTests/ModalityDesign"],
  ]
)
