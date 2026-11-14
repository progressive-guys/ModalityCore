// MARK: - Case AssignmentThenGuard
// MARK: Input
func update(_ state: inout (count: Int, enabled: Bool), value: Int) {
  state.count = value

  guard state.count > 0 else { return }

  print("started")
  print("ready")
}

// MARK: Output
func update(_ state: inout (count: Int, enabled: Bool), value: Int) {
  state.count = value
  guard state.count > 0 else { return }

  print("started")
  print("ready")
}

// MARK: - Case CompoundMutationThenGuard
// MARK: Input
func update(_ value: inout Int) {
  value *= 2

  guard value > 0 else { return }

  print("started")
  print("ready")
}

// MARK: Output
func update(_ value: inout Int) {
  value *= 2
  guard value > 0 else { return }

  print("started")
  print("ready")
}

// MARK: - Case ConditionClosureReadsMutation
// MARK: Input
func update(_ value: inout Int, values: [Int]) {
  value += 1

  guard values.contains(where: { $0 == value }) else { return }

  print("started")
  print("ready")
}

// MARK: Output
func update(_ value: inout Int, values: [Int]) {
  value += 1
  guard values.contains(where: { $0 == value }) else { return }

  print("started")
  print("ready")
}

// MARK: - Case ExplicitSelfPropertyIf
// MARK: Input
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

// MARK: Output
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

// MARK: - Case ImplicitSelfProperty
// MARK: Input
final class Example {

  private var activeConsumers = 0

  func start() {
    activeConsumers += 1

    guard activeConsumers == 1 else { return }

    print("started")
    print("ready")
  }
}

// MARK: Output
final class Example {

  private var activeConsumers = 0

  func start() {
    activeConsumers += 1
    guard activeConsumers == 1 else { return }

    print("started")
    print("ready")
  }
}

// MARK: - Case ShorthandOptionalBinding
// MARK: Input
func update(_ value: inout Int?, input: Int?) {
  value = input

  guard let value else { return }
  print(value)
  print("ready")
}

// MARK: Output
func update(_ value: inout Int?, input: Int?) {
  value = input
  guard let value else { return }
  print(value)
  print("ready")
}
