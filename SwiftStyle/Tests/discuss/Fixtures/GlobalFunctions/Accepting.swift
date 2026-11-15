// MARK: - Разрешённая глобальная функция debugFatalError
func debugFatalError() {}

// MARK: - Функции внутри типа и расширения
enum Examples {
  static func example() {}
}

extension Examples {

  static func outer() {
    func local() {}
    local()
  }
}
