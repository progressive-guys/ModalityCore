// MARK: - Input
public enum Examples {

  struct LongerBeforeShorter {
    static let longer = 1
    static let x = 2
  }
}

// MARK: - Output
public enum Examples {

  struct LongerBeforeShorter {
    static let x = 2
    static let longer = 1
  }
}
