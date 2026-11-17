// MARK: - Интервалы после guard в коротких и многострочных телах (1)
func multilineGuard(_ input: Int?) {
  guard
    let value = input
  else { return }
  print(value)
}

func fourStatements(_ first: Bool) -> Int {
  guard first else { return 0 }
  print(first)
  print("ready")

  return 1
}

func consecutiveGuards(_ input: Int?) {
  guard
    let value = input
  else { return }
  guard value > 0 else { return }
  print(value)
}

/// Output
func multilineGuard(_ input: Int?) {
  guard
    let value = input
  else { return }

  print(value)
}

func fourStatements(_ first: Bool) -> Int {
  guard first else { return 0 }

  print(first)
  print("ready")

  return 1
}

func consecutiveGuards(_ input: Int?) {
  guard
    let value = input
  else { return }

  guard value > 0 else { return }
  print(value)
}

// MARK: - В теле из трёх инструкций пустая строка после guard удаляется
func threeStatements(_ ready: Bool) -> Int {
  guard ready else { return 0 }

  print(ready)
  return 1
}

/// Output
func threeStatements(_ ready: Bool) -> Int {
  guard ready else { return 0 }
  print(ready)
  return 1
}
