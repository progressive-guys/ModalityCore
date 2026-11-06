enum Examples {

  static func configure(_ state: inout (first: Int, second: Int, third: Int, fourth: Int)) {
    state.first = 1
    state.second = 2

    // Set the next pair.
    state.third = 3
    state.fourth = 4
  }
}
