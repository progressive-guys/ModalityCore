// MARK: - Комментарии и другие объявления разделяют варианты перечисления (1)
// Комментарий документации перед вариантом перечисления
func documented() {
  enum Value {

    case first

    /// The middle value.
    case second

    case third
  }
}

// Свойство между вариантами перечисления
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
