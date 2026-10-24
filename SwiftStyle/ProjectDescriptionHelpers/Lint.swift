import ProjectDescription

public extension Target {
  /// Add the checks from the selected SwiftStyle tool version before compilation.
  func withLint(paths: [String]) -> Target {
    guard !paths.isEmpty else { return self }
    var target = self
    target.scripts.insert(
      .pre(
        path: .relativeToCurrentFile("../Scripts/lint.sh"),
        arguments: ["--fix"] + paths.map { "\"${SRCROOT}/\($0)\"" },
        name: "SwiftLint",
        basedOnDependencyAnalysis: false
      ),
      at: 0
    )
    return target
  }
}

public extension Project {
  /// Create library and test targets with the shared settings and source checks.
  static func linted(name: String, targets: [Target], lintPaths: [String: [String]]) -> Project {
    Project(
      name: name,
      settings: .modalitySettings(base: ["ENABLE_USER_SCRIPT_SANDBOXING": "NO"]),
      targets: targets.map { $0.withLint(paths: lintPaths[$0.name] ?? []) },
      resourceSynthesizers: []
    )
  }
}
