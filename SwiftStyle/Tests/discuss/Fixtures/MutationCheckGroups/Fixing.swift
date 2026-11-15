// MARK: - Присваивание соединяется с проверкой изменённого значения
func assignedProperty(_ state: inout (count: Int, enabled: Bool), value: Int) {
  state.count = value

  guard state.count > 0 else { return }

  print("started")
  print("ready")
}

func compoundAssignment(_ value: inout Int) {
  value *= 2

  guard value > 0 else { return }

  print("started")
  print("ready")
}

func closureCondition(_ value: inout Int, values: [Int]) {
  value += 1

  guard values.contains(where: { $0 == value }) else { return }

  print("started")
  print("ready")
}

/// Output
func assignedProperty(_ state: inout (count: Int, enabled: Bool), value: Int) {
  state.count = value
  guard state.count > 0 else { return }

  print("started")
  print("ready")
}

func compoundAssignment(_ value: inout Int) {
  value *= 2
  guard value > 0 else { return }

  print("started")
  print("ready")
}

func closureCondition(_ value: inout Int, values: [Int]) {
  value += 1
  guard values.contains(where: { $0 == value }) else { return }

  print("started")
  print("ready")
}

// MARK: - Изменение свойств с явным и неявным self перед проверкой
final class Example {

  private var activeConsumers = 1
  private var startedConsumers = 0

  func stop() {
    self.activeConsumers -= 1

    if self.activeConsumers == 0 {
      print("stopped")
    }

    print("ready")
  }

  func start() {
    startedConsumers += 1

    guard startedConsumers == 1 else { return }

    print("started")
    print("ready")
  }
}

/// Output
final class Example {

  private var activeConsumers = 1
  private var startedConsumers = 0

  func stop() {
    self.activeConsumers -= 1
    if self.activeConsumers == 0 {
      print("stopped")
    }

    print("ready")
  }

  func start() {
    startedConsumers += 1
    guard startedConsumers == 1 else { return }

    print("started")
    print("ready")
  }
}

// MARK: - Присваивание optional соединяется с краткой привязкой guard let
func update(_ value: inout Int?, input: Int?) {
  value = input

  guard let value else { return }
  print(value)
  print("ready")
}

/// Output
func update(_ value: inout Int?, input: Int?) {
  value = input
  guard let value else { return }
  print(value)
  print("ready")
}
