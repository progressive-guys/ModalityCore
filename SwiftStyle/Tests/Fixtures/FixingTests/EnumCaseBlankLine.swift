// MARK: - Input
enum Examples {
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

// MARK: - Output
enum Examples {

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
