enum Examples {

  static func value() {
    struct Value {
      let member: Int

      var value: Int { self.member }
    }
  }
}
