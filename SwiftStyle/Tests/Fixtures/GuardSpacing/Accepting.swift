// MARK: - Многострочный guard в конце тела и последовательные проверки
// Многострочный guard в конце тела
func process(_ input: Int?) {
  guard
    let value = input,
    value > 0
  else { return }
}

// Многострочный if отделяется от guard и итогового return
func consecutiveChecks(_ first: Bool, _ second: Bool) -> Int {
  guard first else { return 0 }

  if second {
    return 1
  }

  return 2
}
