import ProjectDescription

public struct ModalityCoreTargets {
  private let sourceRoot: String
  private let isStandalone: Bool
  private static let deploymentTargets = DeploymentTargets.multiplatform(iOS: "16.0", macOS: "13.0", visionOS: "1.0")

  public init(
    sourceRoot: String = ".",
    isStandalone: Bool = true
  ) {
    self.sourceRoot = sourceRoot
    self.isStandalone = isStandalone
  }

  private var targets: [Target] {
    [
      .target(
        name: "ModalityCore",
        destinations: [.iPad, .iPhone, .mac, .appleVision],
        product: .framework,
        bundleId: "pure.tones.ModalityCore",
        deploymentTargets: Self.deploymentTargets,
        infoPlist: .default,
        sources: ["\(sourceRoot)/Sources/ModalityCore/**"],
        dependencies: [
          isStandalone ? .package(product: "SwiftMusicTheory") : .target(name: "SwiftMusicTheory")
        ]
      ),
      .target(
        name: "ModalityDesign",
        destinations: [.iPad, .iPhone, .mac, .appleVision],
        product: .framework,
        bundleId: "pure.tones.ModalityDesign",
        deploymentTargets: Self.deploymentTargets,
        infoPlist: .default,
        sources: ["\(sourceRoot)/Sources/ModalityDesign/**"],
        dependencies: [
          .target(name: "ModalityCore"),
          isStandalone ? .package(product: "SwiftMusicTheory") : .target(name: "SwiftMusicTheory")
        ]
      )
    ]
  }

  public var unitTests: [Target] {
    [
      .target(
        name: "ModalityCoreTests",
        destinations: [.iPad, .iPhone, .mac, .appleVision],
        product: .unitTests,
        bundleId: "pure.tones.ModalityCore.tests",
        deploymentTargets: Self.deploymentTargets,
        infoPlist: .default,
        sources: ["\(sourceRoot)/Tests/ModalityCoreTests/**"],
        resources: [
          "\(sourceRoot)/Tests/ModalityCoreTests/TreeTests/Resources/**",
          "\(sourceRoot)/Tests/ModalityCoreTests/FileSystemStoreTests/Resources/**"
        ],
        dependencies: [
          .target(name: "ModalityCore")
        ]
      ),
      .target(
        name: "ModalityDesignTests",
        destinations: [.iPad, .iPhone, .mac, .appleVision],
        product: .unitTests,
        bundleId: "pure.tones.ModalityDesign.tests",
        deploymentTargets: Self.deploymentTargets,
        infoPlist: .default,
        sources: ["\(sourceRoot)/Tests/ModalityDesignTests/**"],
        dependencies: [
          .target(name: "ModalityDesign")
        ]
      )
    ]
  }

  public var all: [Target] { targets + unitTests }
}
