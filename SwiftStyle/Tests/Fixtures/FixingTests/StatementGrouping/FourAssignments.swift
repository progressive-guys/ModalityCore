// MARK: - Input
enum Examples {

  static func configure(_ state: inout (displayLink: Int, callbackTarget: Int, isRunning: Bool, lastError: String?)) {
    state.displayLink = 1
    state.callbackTarget = 2

    state.isRunning = true
    state.lastError = nil
  }
}

// MARK: - Output
enum Examples {

  static func configure(_ state: inout (displayLink: Int, callbackTarget: Int, isRunning: Bool, lastError: String?)) {
    state.displayLink = 1
    state.callbackTarget = 2
    state.isRunning = true
    state.lastError = nil
  }
}
