// MARK: - Accepted

struct Accepted {
  let member: Int
  var value: Int { self.member }
}

// MARK: - Rejected

struct Rejected {
  let member: Int
  var value: Int { self
    .member
  }
}
