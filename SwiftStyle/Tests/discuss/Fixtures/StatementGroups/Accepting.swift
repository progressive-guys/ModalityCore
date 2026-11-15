// MARK: - Действие и его отложенная отмена остаются вместе
func update(_ active: inout Bool) {
  active = true
  defer { active = false }

  let value = active
  print(value)
}

// MARK: - Вызов разделяет группы присваиваний
func configure(_ state: inout (first: Int, second: Int, third: Int, fourth: Int)) {
  state.first = 1
  state.second = 2

  print("start")

  state.third = 3
  state.fourth = 4
}

// MARK: - Параметр замыкания затеняет локальное значение
func process(_ input: Int) {
  let value = input

  [1].forEach { value in
    print(value)
  }

  print(value)
}

// MARK: - Комментарий разделяет группы присваиваний
func configure(_ state: inout (first: Int, second: Int, third: Int, fourth: Int)) {
  state.first = 1
  state.second = 2

  // Set the next pair.
  state.third = 3
  state.fourth = 4
}

// MARK: - Условная компиляция разделяет группы инструкций
func process(_ input: Int) {
  let value = input

  #if os(macOS)
  print(value)
  #endif

  print(value)
  print(value + 1)
}

// MARK: - Вызовы разных объектов идут подряд
func update(_ input: Int, first: inout [Int], second: inout [Int]) {
  let value = input
  first.append(value)
  second.removeAll()
  first.sort()
}

// MARK: - Первое действие не читает подготовленное значение
func update(_ input: Int, values: inout [Int]) {
  let value = input

  values.removeAll()
  values.append(value)
  values.sort()
}

// MARK: - Переменная цикла for затеняет локальное значение
func process(_ input: Int, values: [Int]) {
  let value = input

  for value in values {
    print(value)
  }

  print(value)
}

// MARK: - Тело if читает значения двух подготовленных групп
func check(_ enabled: Bool, _ values: [Int]) {
  let first = values.first ?? 0
  print(first)

  let isReady = enabled

  if enabled {
    print(isReady, first)
  }
}

// MARK: - Неявная ошибка catch затеняет внешнее значение

func process(_ input: Int) {
  let error = input

  do {
    throw NSError(domain: "test", code: 0)
  } catch {
    print(error)
  }

  print(error)
}

// MARK: - Цикл заполняет подготовленную коллекцию
func run(input: [Int]) -> [Int] {
  var result: [Int] = []
  for value in input {
    result.append(value)
  }
  return result
}

// MARK: - Многострочное присваивание разделяет группы
enum Examples {

  static func configure(_ state: inout (first: Int, second: Int, third: Int, fourth: Int), input: Int) {
    state.first = input

    state.second = max(
      input,
      0
    )

    state.third = input
    state.fourth = input
  }
}

// MARK: - Связанные многострочные выражения без пустой строки
func process(_ input: Int) {
  let value = max(
    input,
    0
  )
  print(
    value,
    value + 1
  )
}

// MARK: - Вложенное объявление затеняет внешнее значение
func process(_ input: Int, enabled: Bool) {
  let value = input

  if enabled {
    let value = 1
    print(value)
  }

  print(value)
}

// MARK: - Использование прежнего значения после разделяющего guard
enum Examples {

  static func update(_ input: Int, active: inout Bool, offset: inout Int, notify: (Int) -> Void) {
    let topOffset = input

    guard input > 0 else { return }

    active = true
    offset = topOffset
    notify(offset)
  }
}

// MARK: - Условие repeat читает внешнее значение, а тело объявляет одноимённое локальное
func process(_ input: Int) {
  let value = input

  repeat {
    let value = 0
    print(value)
  } while value > 0

  print(value)
}

// MARK: - Выражение switch читает подготовленное значение
func label(_ kind: Int, center: Int) -> String {
  let angle = center + 90
  let text = switch kind {
  case 0: String(angle)
  default: "circular \(angle)"
  }
  return text
}

// MARK: - Шаблон switch затеняет локальное значение
func process(_ input: Int, alternative: Int?) {
  let value = input

  switch alternative {
  case .some(let value): print(value)
  case .none: break
  }

  print(value)
}
