// MARK: - Input
import AppKit

struct Example {
  var appearance: NSAppearance.Name { .aqua }
  @MainActor
  var background: NSColor { .black }
}

// MARK: - Output
import AppKit

struct Example {
  var appearance: NSAppearance.Name { .aqua }

  @MainActor
  var background: NSColor { .black }
}
