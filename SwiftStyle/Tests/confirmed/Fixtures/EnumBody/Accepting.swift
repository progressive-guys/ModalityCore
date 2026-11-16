// MARK: - Связанные значения варианта перечисления сохраняются на одной строке
enum Value {
  case pair(Int, Int)
}

// MARK: - Комментарии и другие объявления разделяют варианты перечисления
// Комментарий документации перед вариантом перечисления
func documented() {
  enum Value {

    case first

    /// The middle value.
    case second

    case third
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
