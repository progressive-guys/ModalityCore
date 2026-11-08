import ModalityCoreBuild
import ProjectDescription

let workspace = Workspace(
  name: "ModalityCore",
  projects: ModalityCoreProjects.allCases.map { .relativeToManifest($0.rawValue) },
  generationOptions: .options(lastXcodeUpgradeCheck: "27.1")
)
