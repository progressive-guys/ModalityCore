enum Examples {

  static func innerElse(_ first: Bool, _ second: Bool) {
    if first {
      if second {
        print("ready")
      } else {
        print("fallback")
      }
    }
  }
}
