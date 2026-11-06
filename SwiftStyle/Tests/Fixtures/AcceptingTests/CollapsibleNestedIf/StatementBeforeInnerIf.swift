enum Examples {

  static func before(_ first: Bool, _ second: Bool) {
    if first {
      print("start")

      if second {
        print("ready")
      }
    }
  }
}
