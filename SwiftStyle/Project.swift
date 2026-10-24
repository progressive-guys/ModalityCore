import ProjectDescription

let project = Project(
  name: "SwiftStyle",
  settings: .settings(base: [
    "SWIFT_VERSION": "6.0",
    "CODE_SIGNING_ALLOWED": "NO",
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
    ),
    .target(
      name: "SwiftStyleTests",
      destinations: [.mac],
      product: .unitTests,
      bundleId: "dev.progressive-guys.SwiftStyleTests",
      deploymentTargets: .macOS("14.0"),
      sources: ["Tests/SwiftStyleTests/**/*.swift"],
      resources: [
        .folderReference(path: "Tests/Fixtures"),
        .folderReference(path: "Tests/SwiftStyleTests/FixtureStructureTests/Inputs")
      ],
      dependencies: [.target(name: "SwiftStyle")]
    )
  ],
  schemes: [
    .scheme(
      name: "SwiftStyleTests",
      buildAction: .buildAction(targets: ["SwiftStyle", "SwiftStyleTests"]),
      testAction: .targets(["SwiftStyleTests"])
    )
  ]
)
