// MARK: - Удаление пустой строки в конце замыкания
func example() {
  let action = {
    print("value")

  }
  action()
}

/// Output
func example() {
  let action = {
    print("value")
  }
  action()
}

// MARK: - Удаление пустой строки в конце функции
func value() -> Int {
  return 1

}

/// Output
func value() -> Int {
  return 1
}
