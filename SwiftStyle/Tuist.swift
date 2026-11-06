import ProjectDescription

let tuist = Tuist(project: .tuist(plugins: [
  // The checker tests use the scripts and configs from this checkout.
  .local(path: .relativeToCurrentFile("."))
]))
