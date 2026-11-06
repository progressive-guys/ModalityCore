// MARK: - Input
final class Example {

  private var activeConsumers = 1

  func stop() {
    self.activeConsumers -= 1

    if self.activeConsumers == 0 {
      print("stopped")
    }

    print("ready")
  }
}

// MARK: - Output
final class Example {

  private var activeConsumers = 1

  func stop() {
    self.activeConsumers -= 1
    if self.activeConsumers == 0 {
      print("stopped")
    }

    print("ready")
  }
}
