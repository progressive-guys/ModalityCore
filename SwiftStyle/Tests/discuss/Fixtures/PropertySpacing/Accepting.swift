// MARK: - Комментарий документации относится к своему свойству
struct DocCommentBelongsToProperty {

  var a = 1

  /// The second value.
  var b = 2
}

// MARK: - Свойство с наблюдателями считается хранимым
struct StoredPropertyObserver {

  var x = 1 {
    didSet {
      _ = oldValue
    }
  }

  func read() -> Int {
    x
  }
}
