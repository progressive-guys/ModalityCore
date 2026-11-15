// MARK: - Закрытие входного свойства View с неизвестной обёрткой оставлено для ручного решения

@propertyWrapper
struct Input<Value> {
  var wrappedValue: Value
}

struct Example: View {
  @Input var title: String

  var body: some View { Text(title) }
}

let example = Example(title: "hello")
