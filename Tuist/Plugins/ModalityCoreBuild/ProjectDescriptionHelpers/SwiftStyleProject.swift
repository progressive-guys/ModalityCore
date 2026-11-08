import ProjectDescription

public enum SwiftStyleProject {

  public static var targets: [Target] {
    [
      .target(
        name: "SwiftStyle",
        destinations: [.mac],
        product: .commandLineTool,
        bundleId: "dev.progressive-guys.SwiftStyle",
        deploymentTargets: .macOS("14.0"),
        sources: ["Sources/**"]
      ),
      .target(
        name: "SwiftStyleTests",
        destinations: [.mac],
        product: .unitTests,
        bundleId: "dev.progressive-guys.SwiftStyleTests",
        deploymentTargets: .macOS("14.0"),
        buildableFolders: ["Tests/SwiftStyleTests"],
        copyFiles: [.resources(
          name: "Embed fixture bundle",
          files: [.buildProduct(name: "SwiftStyleFixtures")]
        )],
        dependencies: [.target(name: "SwiftStyle"), .project(target: "ModalityCore", path: "..")]
      ),
      .target(
        name: "SwiftStyleFixtures",
        destinations: [.mac],
        product: .bundle,
        bundleId: "dev.progressive-guys.SwiftStyleFixtures",
        deploymentTargets: .macOS("14.0"),
        copyFiles: [.resources(
          name: "Copy fixtures",
          files: [.folderReference(path: "Tests/Fixtures")]
        )]
      )
    ]
  }
}
