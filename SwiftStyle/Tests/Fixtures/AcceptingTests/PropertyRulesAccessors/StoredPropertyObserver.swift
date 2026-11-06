public enum Examples {

  /// A stored-property observer does not use the long computed-property spacing rule.
  struct StoredPropertyObserver {

    var x = 1 {
      didSet {
        _ = oldValue
      }
    }

    func read() -> Int { x }
  }
}
