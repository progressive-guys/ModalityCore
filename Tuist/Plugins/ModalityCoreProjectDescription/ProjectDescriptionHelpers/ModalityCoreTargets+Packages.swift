import ProjectDescription

public extension ModalityCoreTargets {
  static let packages: [Package] = [
    .remote(url: "https://github.com/modality-lab/SwiftMusicTheory.git", requirement: .branch("main"))
  ]
}
