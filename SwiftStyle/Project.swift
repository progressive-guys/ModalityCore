import ModalityBuild
import ModalityCoreBuild
import ProjectDescription

let lintPaths: [String: [String]] = [
  "SwiftStyle": ["Sources"],
  "SwiftStyleTests": ["Tests/SwiftStyleTests"]
]

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
  targets: SwiftStyleProject.targets.map {
    $0.withLint(paths: lintPaths[$0.name] ?? [], script: .relativeToManifest("Scripts/lint.sh"))
  },
  schemes: [
    .scheme(
      name: "SwiftStyleTests",
      buildAction: .buildAction(targets: ["SwiftStyle", "SwiftStyleTests"]),
      testAction: .targets(["SwiftStyleTests"])
    )
  ],
  resourceSynthesizers: [.files(plugin: "ModalityBuild", extensions: ["swift"])]
)
