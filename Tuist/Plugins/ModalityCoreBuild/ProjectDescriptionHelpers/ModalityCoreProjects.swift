import ProjectDescription

public enum ModalityCoreProjects: String, CaseIterable {

  case library = "."
  case swiftStyle = "SwiftStyle"

  public func targets(swiftMusicTheory: TargetDependency) -> [Target] {
    switch self {
    case .library:
      ModalityCoreProject.targets(swiftMusicTheory: swiftMusicTheory)

    case .swiftStyle:
      SwiftStyleProject.targets
    }
  }
}
