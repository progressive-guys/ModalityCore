// MARK: - Независимые проверки сохраняют границы после изменения значения
// Проверка читает другое свойство
func otherProperty(_ state: inout (count: Int, enabled: Bool)) {
  state.count += 1

  guard state.enabled else { return }

  print("started")
  print("ready")
}

// Проверка обращается к другому объекту
func otherObject(_ left: inout (count: Int, enabled: Bool), right: (count: Int, enabled: Bool)) {
  left.count += 1

  guard right.count > 0 else { return }

  print("started")
  print("ready")
}

// Между изменением значения и проверкой есть инструкция
func interveningAction(_ value: inout Int) {
  value += 1
  print("tick")

  guard value > 0 else { return }

  print("ready")
}

// MARK: - Многострочное изменение значения перед проверкой
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

// MARK: - Чтение в теле и затенение в условии сохраняют границы групп
// Изменённое значение читается только в теле if
func readInBody(_ value: inout Int, enabled: Bool) {
  value += 1

  if enabled {
    print(value)
  }

  print("ready")
}

// Привязка в условии затеняет исходный объект
func shadowedBinding(_ state: inout (count: Int, enabled: Bool), other: (count: Int, enabled: Bool)?) {
  state.count += 1

  if let state = other, state.count > 0 {
    print(state.count)
  }

  print("ready")
}
