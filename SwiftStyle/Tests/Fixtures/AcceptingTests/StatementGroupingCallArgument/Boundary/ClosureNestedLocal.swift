enum Example {

  static func run(input: Int, sink: @escaping (Int) -> Void) {
    let callback = { (raw: Int) in
      let value = raw
      sink(value)

      let next = value + 1
      sink(next)
    }

    callback(input)
  }
}
