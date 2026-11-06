import Foundation
import ModalityBuild
import ProjectDescription

let fixtureRoot = URL(fileURLWithPath: #filePath)
  .deletingLastPathComponent()
  .appendingPathComponent("Tests/Fixtures")

let fixtureDirectories = Set(try FileManager.default.subpathsOfDirectory(atPath: fixtureRoot.path)
  .filter { $0.hasSuffix(".swift") }
  .map { ($0 as NSString).deletingLastPathComponent })

let project = Project(
  name: "SwiftStyle",
  settings: .settings(base: [
    "ARCHS": "$(NATIVE_ARCH_ACTUAL)",
    "SWIFT_VERSION": "6.0",
    "CODE_SIGNING_ALLOWED": "NO",
    "ENABLE_USER_SCRIPT_SANDBOXING": "NO",
    "SWIFT_INCLUDE_PATHS": "$(DEVELOPER_DIR)/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/host",
    "LIBRARY_SEARCH_PATHS": "$(inherited) $(DEVELOPER_DIR)/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/host",
    "LD_RUNPATH_SEARCH_PATHS":
      "$(inherited) $(DEVELOPER_DIR)/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/host"
  ]),
  targets: [
    .target(
      name: "SwiftStyle",
      destinations: [.mac],
      product: .commandLineTool,
      bundleId: "dev.progressive-guys.SwiftStyle",
      deploymentTargets: .macOS("14.0"),
      sources: ["Sources/**"]
    ).withLint(
      paths: ["Sources"], script: .relativeToManifest("Scripts/lint.sh")
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
      dependencies: [.target(name: "SwiftStyle"), .library("ModalityCore")]
    )
    .withLint(
      paths: ["Tests/SwiftStyleTests"], script: .relativeToManifest("Scripts/lint.sh")
    ),
    .target(
      name: "SwiftStyleFixtures",
      destinations: [.mac],
      product: .bundle,
      bundleId: "dev.progressive-guys.SwiftStyleFixtures",
      deploymentTargets: .macOS("14.0"),
      copyFiles: fixtureDirectories.sorted().map { directory in
          .resources(
            name: "Copy \(directory)",
            subpath: "Fixtures/\(directory)",
            files: [.glob(pattern: .relativeToManifest("Tests/Fixtures/\(directory)/*.swift"))]
          )
      }
    )
  ],
  schemes: [
    .scheme(
      name: "SwiftStyleTests",
      buildAction: .buildAction(targets: ["SwiftStyle", "SwiftStyleTests"]),
      testAction: .targets(["SwiftStyleTests"])
    )
  ],
  resourceSynthesizers: [.files(plugin: "ModalityBuild", extensions: ["swift"])]
)
