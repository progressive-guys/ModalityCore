enum Examples {

  static func outerElse(_ first: Bool, _ second: Bool) {
    if first {
      if second {
        print("ready")
      }
    } else {
      print("fallback")
    }
  }
}
