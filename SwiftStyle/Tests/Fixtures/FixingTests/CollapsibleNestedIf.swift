// MARK: - Input
enum Examples {
  static func binding(_ value: Int?) {
    if let value {
      if value > 0 { print(value) }
    }
  }

  static func comments(_ first: Bool, _ second: Bool) {
    if first {
      // Check the next condition only after the first one succeeds.
      if second { print("ready") }
    }
  }

  static func nested(_ first: Bool, _ second: Bool) {
    if first {
      if second {
        print("ready")
      }
    }
  }

  static func threeLevels(_ first: Bool, _ second: Bool, _ third: Bool) {
    if first {
      if second {
        if third { print("ready") }
      }
    }
  }
}

// MARK: - Output
enum Examples {

  static func binding(_ value: Int?) {
    if let value ,
       value > 0
    {
      print(value)
    }
    
  }

  static func comments(_ first: Bool, _ second: Bool) {
    if first ,
      // Check the next condition only after the first one succeeds.
       second
    {
      print("ready")
    }
    
  }

  static func nested(_ first: Bool, _ second: Bool) {
    if first ,
       second
    {
        print("ready")
      }
    
  }

  static func threeLevels(_ first: Bool, _ second: Bool, _ third: Bool) {
    if first ,
       second ,
         third
    {
      print("ready")
    }
      
    
  }
}
