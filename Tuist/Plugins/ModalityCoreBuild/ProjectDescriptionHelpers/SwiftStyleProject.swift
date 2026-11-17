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
        resources: [.folderReference(path: "Tests/Fixtures")],
        buildableFolders: ["Tests/SwiftStyleTests"],
        dependencies: [.target(name: "SwiftStyle"), .project(target: "ModalityCore", path: "..")]
      )
    ]
  }
}
