// MARK: - Переносы присваивания, приведения типа и обращения к свойству
enum Examples {

  static func value(_ source: Int) -> Int {
    let result =
      source
    return result
  }

  static func value(_ source: Any) -> Int? {
    source
      as? Int
  }

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

  static func value(_ source: Int) -> Int {
    let result = source
    return result
  }

  static func value(_ source: Any) -> Int? {
    source as? Int
  }

  static func value() {
    struct Value {

      let member: Int

      var value: Int {
        self.member
      }
    }
  }
}
