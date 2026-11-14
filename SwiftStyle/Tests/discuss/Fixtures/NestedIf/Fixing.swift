// MARK: - Case Binding
// MARK: Input
enum Example {

  static func binding(_ value: Int?) {
    if let value {
      if value > 0 { print(value) }
    }
  }
}

// MARK: Output
enum Example {

  static func binding(_ value: Int?) {
    if let value,
       value > 0
    {
      print(value)
    }
  }
}

// MARK: - Case ClosingComment
// MARK: Input
func run(_ first: Bool, _ second: Bool, body: () -> Void) {
  if first {
    if second {
      body()
    } // Keep this closing comment.
  }
}

// MARK: Output
func run(_ first: Bool, _ second: Bool, body: () -> Void) {
  if first,
     second
  {
    body()
  } // Keep this closing comment.
}

// MARK: - Case CommentBetweenConditions
// MARK: Input
enum Example {

  static func comments(_ first: Bool, _ second: Bool) {
    if first {
      // Check the next condition only after the first one succeeds.
      if second { print("ready") }
    }
  }
}

// MARK: Output
enum Example {

  static func comments(_ first: Bool, _ second: Bool) {
    if first,
      // Check the next condition only after the first one succeeds.
       second
    {
      print("ready")
    }
  }
}

// MARK: - Case ThreeLevels
// MARK: Input
enum Example {

  static func threeLevels(_ first: Bool, _ second: Bool, _ third: Bool) {
    if first {
      if second {
        if third { print("ready") }
      }
    }
  }
}

// MARK: Output
enum Example {

  static func threeLevels(_ first: Bool, _ second: Bool, _ third: Bool) {
    if first,
       second,
       third
    {
      print("ready")
    }
  }
}

// MARK: - Case TwoLevels
// MARK: Input
enum Example {

  static func nested(_ first: Bool, _ second: Bool) {
    if first {
      if second {
        print("ready")
      }
    }
  }
}

// MARK: Output
enum Example {

  static func nested(_ first: Bool, _ second: Bool) {
    if first,
       second
    {
      print("ready")
    }
  }
}
