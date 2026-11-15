// MARK: - Правая часть присваивания соединяется со знаком равенства
enum Examples {
  static func value(_ source: Int) -> Int {
    let result =
      source
    return result
  }
}

/// Output
enum Examples {

  static func value(_ source: Int) -> Int {
    let result = source
    return result
  }
}

// MARK: - Условное приведение типа соединяется с операндом
enum Examples {
  static func value(_ source: Any) -> Int? {
    source
      as? Int
  }
}

/// Output
enum Examples {

  static func value(_ source: Any) -> Int? {
    source as? Int
  }
}

// MARK: - Self и имя свойства соединяются, выражение getter переносится в тело
enum Examples {
  static func value() {
    struct Value {
      let member: Int
      var value: Int { self
        .member
      }
    }
  }
}

/// Output
enum Examples {

  static func value() {
    struct Value {

      let member: Int

      var value: Int {
        self.member
      }
    }
  }
}
