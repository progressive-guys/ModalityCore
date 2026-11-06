// MARK: - Input
enum Examples {
  final class Panel {
    var title = ""
    func setFrame(_ width: Int) {}
    func present(_ completion: () -> Void) { completion() }
  }

  static func gapBeforeArgumentUse() {
    let panel = Panel()

    print(panel)
    print("step")
    print("done")
  }

  static func gapBeforePropertyConfiguration() {
    let panel = Panel()

    panel.title = "candidate.png"
    print("step")
    print("done")
  }

  static func gapBeforeMethodConfiguration() {
    let panel = Panel()

    panel.setFrame(100)
    print("step")
    print("done")
  }

  static func missingGapAfterConfiguration() {
    let panel = Panel()
    panel.title = "candidate.png"
    let other = Panel()
    other.title = "other.png"
  }

  static func multilineConfiguration() {
    let panel = Panel()
    panel.title = "candidate.png"
    panel.present {
      print(panel.title)
    }
  }

  static func newLocalConfiguration() {
    let panel = Panel()
    panel.title = "candidate.png"
    panel.setFrame(100)

    let other = Panel()
    other.title = "other.png"

    panel.present {
      print(other.title)
    }
  }

  static func shadowedClosureIsSeparate() {
    let panel = Panel()
    _ = [1].map { panel in panel + 1 }
    print(panel)
    print("done")
  }

  static func otherReceiverReadsLocal(_ other: Panel) {
    let panel = Panel()
    other.title = panel.title
    print(other.title)
    print(panel.title)
  }
}

// MARK: - Output
enum Examples {

  final class Panel {
    var title = ""

    func setFrame(_ width: Int) {}
    func present(_ completion: () -> Void) { completion() }
  }

  static func gapBeforeArgumentUse() {
    let panel = Panel()
    print(panel)
    print("step")
    print("done")
  }

  static func gapBeforePropertyConfiguration() {
    let panel = Panel()
    panel.title = "candidate.png"
    print("step")
    print("done")
  }

  static func gapBeforeMethodConfiguration() {
    let panel = Panel()
    panel.setFrame(100)
    print("step")
    print("done")
  }

  static func missingGapAfterConfiguration() {
    let panel = Panel()
    panel.title = "candidate.png"

    let other = Panel()
    other.title = "other.png"
  }

  static func multilineConfiguration() {
    let panel = Panel()
    panel.title = "candidate.png"
    panel.present {
      print(panel.title)
    }
  }

  static func newLocalConfiguration() {
    let panel = Panel()
    panel.title = "candidate.png"
    panel.setFrame(100)

    let other = Panel()
    other.title = "other.png"

    panel.present {
      print(other.title)
    }
  }

  static func shadowedClosureIsSeparate() {
    let panel = Panel()

    _ = [1].map { panel in panel + 1 }
    print(panel)
    print("done")
  }

  static func otherReceiverReadsLocal(_ other: Panel) {
    let panel = Panel()
    other.title = panel.title
    print(other.title)
    print(panel.title)
  }
}
