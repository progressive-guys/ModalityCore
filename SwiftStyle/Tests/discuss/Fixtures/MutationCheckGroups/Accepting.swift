// MARK: - Case DifferentProperty
func update(_ state: inout (count: Int, enabled: Bool)) {
  state.count += 1

  guard state.enabled else { return }

  print("started")
  print("ready")
}

// MARK: - Case DifferentReceiver
func update(_ left: inout (count: Int, enabled: Bool), right: (count: Int, enabled: Bool)) {
  left.count += 1

  guard right.count > 0 else { return }

  print("started")
  print("ready")
}

// MARK: - Case InterveningStatement
func update(_ value: inout Int) {
  value += 1
  print("tick")

  guard value > 0 else { return }

  print("ready")
}

// MARK: - Case MultilineMutationBeforeCheck
enum Examples {

  static func update(_ value: inout Int, input: Int) {
    value = max(
      input,
      0
    )

    if value > 0 {
      print(value)
    }
  }
}

// MARK: - Case OnlyIfBodyReadsMutation
func update(_ value: inout Int, enabled: Bool) {
  value += 1

  if enabled {
    print(value)
  }

  print("ready")
}

// MARK: - Case ReceiverBindingShadows
func update(_ state: inout (count: Int, enabled: Bool), other: (count: Int, enabled: Bool)?) {
  state.count += 1

  if let state = other, state.count > 0 {
    print(state.count)
  }

  print("ready")
}
