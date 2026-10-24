// MARK: - Accepted

enum Accepted {
  static func compact() {
    enum Value {
      case first
      case second
    }
  }

  static func grouped() {
    enum Value {
      case first, second
    }
  }

  static func associatedValues() {
    enum Value {
      case first(
        Int,
        String
      )

      case second
    }
  }

  static func documented() {
    enum Value {
      case first

      /// The middle value.
      case second

      case third
    }
  }

  static func inlineComment() {
    enum Value {
      case first // First value.
      case second
    }
  }

  static func blockComment() {
    enum Value {
      case first /* First
        value. */

      case second
    }
  }

  static func conditional() {
    enum Value {
      #if os(macOS)
      case first
      case second
      #endif
    }
  }

  static func otherDeclarations() {
    enum Value {
      case first
      static var value: Int { 1 }
      case second
    }
  }
}

// MARK: - Rejected

enum Rejected {
  static func compactGap() {
    enum Value {
      case first

      case second
    }
  }

  static func associatedValues() {
    enum Value {
      case first(
        Int,
        String
      )
      case second
    }
  }

  static func beforeComment() {
    enum Value {
      case first
      /// The next value.
      case second
    }
  }

  static func afterComment() {
    enum Value {
      /// The first value.
      case first
      case second
    }
  }

  static func gapAfterComment() {
    enum Value {
      case first
      /// The next value.

      case second
    }
  }

  static func conditionalGap() {
    enum Value {
      #if os(macOS)
      case first

      case second
      #endif
    }
  }

  static func extraGap() {
    enum Value {
      case first


      /// The next value.
      case second
    }
  }
}
