// MARK: - Многострочный guard в конце тела
func process(_ input: Int?) {
  guard
    let value = input,
    value > 0
  else { return }
}

// MARK: - Разные однострочные проверки в коротком теле
func consecutiveChecks(_ first: Bool, _ second: Bool) -> Int {
  guard first else { return 0 }
  if second { return 1 }
  return 2
}
