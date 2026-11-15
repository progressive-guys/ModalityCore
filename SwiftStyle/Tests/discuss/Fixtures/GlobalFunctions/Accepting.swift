// MARK: - Разрешённая глобальная функция debugFatalError
func debugFatalError() {}

// MARK: - Локальная функция внутри расширения
enum Examples {}

extension Examples {

  static func outer() {
    func local() {}
    local()
  }
}

// MARK: - Статическая функция внутри типа
enum Examples {
  static func example() {}
}
