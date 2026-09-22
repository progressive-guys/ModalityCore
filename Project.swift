import ProjectDescription
import ModalityCoreProjectDescription

let project = Project(
  name: "ModalityCore",
  organizationName: "Modality",
  packages: ModalityCoreTargets.packages,
  settings: .settings(configurations: [
    .debug(name: "Debug", xcconfig: "Configuration/Signing.xcconfig"),
    .release(name: "Release", xcconfig: "Configuration/Signing.xcconfig")
  ]),
  targets: ModalityCoreTargets().all,
  additionalFiles: ["README.md", "Package.swift", "Tuist.swift", "Tuist/**", "Configuration/**"],
  resourceSynthesizers: [.strings()]
)
