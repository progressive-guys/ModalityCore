enum Examples {

  struct OneEnumCase {

    enum Key: String, CodingKey {
      case value
    }

    let value: Int
  }
}
