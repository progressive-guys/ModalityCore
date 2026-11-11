// MARK: - Input

enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let normalized = input + 1
    sink(normalized)


    let fingerprint = normalized * 31
    sink(fingerprint)
  }
}

// MARK: - Output

enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let normalized = input + 1
    sink(normalized)

    let fingerprint = normalized * 31
    sink(fingerprint)
  }
}
