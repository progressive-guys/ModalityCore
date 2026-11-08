import ProjectDescription

public enum ModalityCoreProject {

  public static func targets(swiftMusicTheory: TargetDependency) -> [Target] {
    [
      .target(
        name: "ModalityCore",
        destinations: [.iPhone, .iPad, .mac, .appleVision],
        product: .framework,
        bundleId: "com.modality.ModalityCore",
        infoPlist: .default,
        sources: ["ModalityCore/Sources/**"],
        dependencies: [swiftMusicTheory],
        settings: .settings(configurations: [.release(name: "Release", settings: ["ENABLE_TESTABILITY": "YES"])])
      ),
      .target(
        name: "ModalityDesign",
        destinations: [.iPhone, .iPad, .mac, .appleVision],
        product: .framework,
        bundleId: "com.modality.ModalityDesign",
        infoPlist: .default,
        sources: ["ModalityDesign/Sources/**"],
        resources: ["ModalityDesign/Resources/**"],
        dependencies: [.target(name: "ModalityCore"), swiftMusicTheory],
        settings: .settings(configurations: [.release(name: "Release", settings: ["ENABLE_TESTABILITY": "YES"])])
      ),
      .target(
        name: "ModalityCoreUnitTests",
        destinations: [.iPhone, .iPad, .mac, .appleVision],
        product: .unitTests,
        bundleId: "com.modality.ModalityCoreUnitTests",
        infoPlist: .default,
        sources: ["UnitTests/ModalityCore/**"],
        resources: [
          "UnitTests/ModalityCore/TreeTests/Resources/**",
          .folderReference(path: "UnitTests/ModalityCore/FileSystemStoreTests/Resources")
        ],
        dependencies: [.target(name: "ModalityCore")],
        settings: .settings(base: ["MACOSX_DEPLOYMENT_TARGET": "14.0"])
      ),
      .target(
        name: "ModalityDesignUnitTests",
        destinations: [.iPhone, .iPad, .mac, .appleVision],
        product: .unitTests,
        bundleId: "com.modality.ModalityDesignUnitTests",
        infoPlist: .default,
        sources: ["UnitTests/ModalityDesign/**"],
        dependencies: [.target(name: "ModalityDesign")],
        settings: .settings(base: ["MACOSX_DEPLOYMENT_TARGET": "14.0"])
      ),
    ]
  }
}
