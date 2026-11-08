import ModalityBuild
import ModalityCoreBuild
import ProjectDescription

let project = Project.linted(
  name: "ModalityCore",
  targets: ModalityCoreProject.targets(swiftMusicTheory: .library("SwiftMusicTheory")),
  lintPaths: [
    "ModalityCore": ["ModalityCore/Sources"],
    "ModalityDesign": ["ModalityDesign/Sources"],
    "ModalityCoreUnitTests": ["UnitTests/ModalityCore"],
    "ModalityDesignUnitTests": ["UnitTests/ModalityDesign"],
  ]
)
