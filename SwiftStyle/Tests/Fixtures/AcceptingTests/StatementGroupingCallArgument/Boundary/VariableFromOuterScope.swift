enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    let visit = {
      sink(value)

      let next = value + 1
      sink(next)
      sink(next)
    }

    visit()
  }
}
