// MARK: - Удаление пустой строки в конце функции и замыкания
func example() {
  let action = {
    print("value")

  }
  action()
}

func value() -> Int {
  return 1

}

/// Output
func example() {
  let action = {
    print("value")
  }
  action()
}

func value() -> Int {
  return 1
}
