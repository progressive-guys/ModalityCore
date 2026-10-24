import ProjectDescription

let tuist = Tuist(project: .tuist(plugins: [
  .git(url: "https://github.com/modality-lab/ModalityCore.git", tag: "1.1.0", directory: "SwiftStyle")
]))
