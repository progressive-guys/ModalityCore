// MARK: - Input
enum Examples {

  @MainActor
  static func deliver(_ input: Int, onFrame: (Int) -> Void, clear: () -> Void) {
    // Read the frame time.
    let timestamp = input
    onFrame(timestamp)

    clear()
  }
}

// MARK: - Output
enum Examples {

  @MainActor
  static func deliver(_ input: Int, onFrame: (Int) -> Void, clear: () -> Void) {
    // Read the frame time.
    let timestamp = input
    onFrame(timestamp)
    clear()
  }
}
