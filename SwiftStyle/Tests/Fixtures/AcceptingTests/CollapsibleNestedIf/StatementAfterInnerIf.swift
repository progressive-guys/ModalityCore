enum Examples {

  static func after(_ first: Bool, _ second: Bool) {
    if first {
      if second {
        print("ready")
      }

      print("end")
    }
  }
}
