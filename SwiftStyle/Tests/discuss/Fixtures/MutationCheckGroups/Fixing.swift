// MARK: - Присваивание свойства соединяется с guard, читающим это свойство
func update(_ state: inout (count: Int, enabled: Bool), value: Int) {
  state.count = value

  guard state.count > 0 else { return }

  print("started")
  print("ready")
}

/// Output
func update(_ state: inout (count: Int, enabled: Bool), value: Int) {
  state.count = value
  guard state.count > 0 else { return }

  print("started")
  print("ready")
}

// MARK: - Составное присваивание соединяется с guard, читающим изменённое значение
func update(_ value: inout Int) {
  value *= 2

  guard value > 0 else { return }

  print("started")
  print("ready")
}

/// Output
func update(_ value: inout Int) {
  value *= 2
  guard value > 0 else { return }

  print("started")
  print("ready")
}

// MARK: - Изменение значения соединяется с guard, читающим его в замыкании
func update(_ value: inout Int, values: [Int]) {
  value += 1

  guard values.contains(where: { $0 == value }) else { return }

  print("started")
  print("ready")
}

/// Output
func update(_ value: inout Int, values: [Int]) {
  value += 1
  guard values.contains(where: { $0 == value }) else { return }

  print("started")
  print("ready")
}

// MARK: - Изменение свойства с явным self соединяется с проверкой if
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

/// Output
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

// MARK: - Изменение свойства с неявным self соединяется с guard
final class Example {

  private var activeConsumers = 0

  func start() {
    activeConsumers += 1

    guard activeConsumers == 1 else { return }

    print("started")
    print("ready")
  }
}

/// Output
final class Example {

  private var activeConsumers = 0

  func start() {
    activeConsumers += 1
    guard activeConsumers == 1 else { return }

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
