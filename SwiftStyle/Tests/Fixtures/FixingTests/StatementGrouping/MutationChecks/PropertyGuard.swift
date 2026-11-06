// MARK: - Input
final class Example {

  private var activeConsumers = 0

  func start() {
    activeConsumers += 1

    guard activeConsumers == 1 else { return }

    print("started")
    print("ready")
  }
}

// MARK: - Output
final class Example {

  private var activeConsumers = 0

  func start() {
    activeConsumers += 1
    guard activeConsumers == 1 else { return }

    print("started")
    print("ready")
  }
}
