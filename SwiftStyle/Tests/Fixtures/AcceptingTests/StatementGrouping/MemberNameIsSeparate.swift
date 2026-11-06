enum Examples {

  static func process(_ input: Int, other: (value: Int, count: Int)) {
    let value = input

    print(other.value)
    print(other.count)

    print(value)
  }
}
