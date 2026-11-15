// MARK: - Комментарий документации перед вариантом перечисления
func documented() {
  enum Value {

    case first

    /// The middle value.
    case second

    case third
  }
}

// MARK: - Свойство между вариантами перечисления
func otherDeclarations() {
  enum Value {

    case first
    static var value: Int { 1 }
    case second
  }
}

// MARK: - Многострочный комментарий после варианта
func blockComment() {
  enum Value {

    case first /* First
      value. */

    case second
  }
}
