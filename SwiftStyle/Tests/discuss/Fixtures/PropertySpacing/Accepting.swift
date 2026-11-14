// MARK: - Case DocCommentBelongsToProperty
struct DocCommentBelongsToProperty {
  var a = 1

  /// The second value.
  var b = 2
}

// MARK: - Case ObserverIsStored
struct StoredPropertyObserver {

  var x = 1 {
    didSet {
      _ = oldValue
    }
  }

  func read() -> Int { x }
}
