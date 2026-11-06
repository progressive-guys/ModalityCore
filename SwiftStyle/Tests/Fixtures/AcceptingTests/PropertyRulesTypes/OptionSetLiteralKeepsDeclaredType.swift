public enum Examples {

  struct OptionSetLiteralKeepsDeclaredType: OptionSet {

    static let c: OptionSetLiteralKeepsDeclaredType = [.a, .b]
    static let a = OptionSetLiteralKeepsDeclaredType(rawValue: 1)
    static let b = OptionSetLiteralKeepsDeclaredType(rawValue: 2)
    let rawValue: Int

    init(rawValue: Int) {
      self.rawValue = rawValue
    }
  }
}
