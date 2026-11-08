import ProjectDescription

let tuist = Tuist(project: .tuist(plugins: [
  .local(path: .relativeToCurrentFile("Tuist/Plugins/ModalityCoreBuild")),
  .local(path: .relativeToCurrentFile("SwiftStyle"))
]))
