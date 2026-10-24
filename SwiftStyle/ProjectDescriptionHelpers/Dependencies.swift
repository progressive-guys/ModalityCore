import ProjectDescription

public extension TargetDependency {
  /// Use a package product unless the consumer supplies a directory of local projects.
  static func library(_ product: String, package: String? = nil) -> TargetDependency {
    let root = Environment.localProjectsRoot.getString(default: "")
    guard !root.isEmpty else { return .external(name: product) }
    return .project(target: product, path: Path(stringLiteral: "\(root)/\(package ?? product)"))
  }
}
