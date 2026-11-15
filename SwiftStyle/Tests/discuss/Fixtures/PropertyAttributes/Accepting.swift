// MARK: - Комментарий препятствует объединению аннотации со свойством
@propertyWrapper
struct Injected<Value> {
  var wrappedValue: Value
}

struct Settings {

  @Injected // An attached attribute comment.
  var value = 1
}
