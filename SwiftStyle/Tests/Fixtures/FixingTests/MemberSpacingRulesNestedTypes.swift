// MARK: - Input
enum Examples {

  struct OneEnumCaseOpeningGap {

    enum Key {

      case value
    }
  }

  struct MultipleEnumCasesOpeningGap {

    enum Key {
      case a, b
    }
  }

  struct MissingNestedTypeGap {

    enum Key {
      case value
    }
    let value: Int
  }

  struct MissingGapBeforeNestedType {

    let value: Int
    enum Key {
      case value
    }
  }

  struct MissingOpeningGap {
    var x = 1
  }

  struct MissingOpeningGapBeforeComment {
    // Initial value.
    var x = 1
  }
}

// MARK: - Output
enum Examples {

  struct OneEnumCaseOpeningGap {
    enum Key {
      case value
    }
  }

  struct MultipleEnumCasesOpeningGap {
    enum Key {
      case a, b
    }
  }

  struct MissingNestedTypeGap {

    enum Key {
      case value
    }

    let value: Int
  }

  struct MissingGapBeforeNestedType {

    enum Key {
      case value
    }

    let value: Int
  }

  struct MissingOpeningGap {
    var x = 1
  }

  struct MissingOpeningGapBeforeComment {
    // Initial value.
    var x = 1
  }
}
