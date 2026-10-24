// MARK: - Accepted

enum Accepted {
  static func value() {
    struct Value {
      let member: Int
      var value: Int { self.member }
    }
  }
}

// MARK: - Rejected

enum Rejected {
  static func value() {
    struct Value {
      let member: Int
      var value: Int { self
        .member
      }
    }
  }
}
