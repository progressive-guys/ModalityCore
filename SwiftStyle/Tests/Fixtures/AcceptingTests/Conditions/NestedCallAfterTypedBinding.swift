enum Examples {

  static func typedBinding(_ text: String) -> Bool {
    if let parsed: Int = Int(text), abs(abs(parsed)) > 0 { return true }
    return false
  }
}
