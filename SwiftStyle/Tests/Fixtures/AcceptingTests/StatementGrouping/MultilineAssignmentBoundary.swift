enum Examples {

  static func configure(_ state: inout (first: Int, second: Int, third: Int, fourth: Int), input: Int) {
    state.first = input

    state.second = max(
      input,
      0
    )

    state.third = input
    state.fourth = input
  }
}
