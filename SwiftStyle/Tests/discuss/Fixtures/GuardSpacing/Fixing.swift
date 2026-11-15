// MARK: - Пустая строка после многострочного guard
func process(_ input: Int?) {
  guard
    let value = input
  else { return }
  print(value)
}

/// Output
func process(_ input: Int?) {
  guard
    let value = input
  else { return }

  print(value)
}

// MARK: - В теле из четырёх инструкций guard отделяется пустой строкой
func value(_ first: Bool) -> Int {
  guard first else { return 0 }
  print(first)
  print("ready")

  return 1
}

/// Output
func value(_ first: Bool) -> Int {
  guard first else { return 0 }

  print(first)
  print("ready")

  return 1
}

// MARK: - Между многострочным и однострочным guard добавляется пустая строка
func process(_ input: Int?) {
  guard
    let value = input
  else { return }
  guard value > 0 else { return }
  print(value)
}

/// Output
func process(_ input: Int?) {
  guard
    let value = input
  else { return }

  guard value > 0 else { return }
  print(value)
}

// MARK: - В теле из трёх инструкций пустая строка после guard удаляется
func value(_ ready: Bool) -> Int {
  guard ready else { return 0 }

  print(ready)
  return 1
}

/// Output
func value(_ ready: Bool) -> Int {
  guard ready else { return 0 }
  print(ready)
  return 1
}
