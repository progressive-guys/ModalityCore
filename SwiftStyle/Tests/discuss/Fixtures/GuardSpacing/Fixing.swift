// MARK: - Case AfterMultilineGuard
// MARK: Input
func process(_ input: Int?) {
  guard
    let value = input
  else { return }
  print(value)
}

// MARK: Output
func process(_ input: Int?) {
  guard
    let value = input
  else { return }

  print(value)
}

// MARK: - Case LongBodyAfterInlineGuard
// MARK: Input
func value(_ first: Bool) -> Int {
  guard first else { return 0 }
  print(first)
  print("ready")

  return 1
}

// MARK: Output
func value(_ first: Bool) -> Int {
  guard first else { return 0 }

  print(first)
  print("ready")

  return 1
}

// MARK: - Case MultilineThenInlineGuard
// MARK: Input
func process(_ input: Int?) {
  guard
    let value = input
  else { return }
  guard value > 0 else { return }
  print(value)
}

// MARK: Output
func process(_ input: Int?) {
  guard
    let value = input
  else { return }

  guard value > 0 else { return }
  print(value)
}

// MARK: - Case ShortBodyAfterInlineGuard
// MARK: Input
func value(_ ready: Bool) -> Int {
  guard ready else { return 0 }

  print(ready)
  return 1
}

// MARK: Output
func value(_ ready: Bool) -> Int {
  guard ready else { return 0 }
  print(ready)
  return 1
}
