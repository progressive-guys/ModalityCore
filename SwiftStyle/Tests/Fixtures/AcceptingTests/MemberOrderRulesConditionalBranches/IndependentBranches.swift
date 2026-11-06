enum Examples {

  struct IndependentBranches {

    #if os(macOS)
    var value = 1

    init() {}

    var result: Int { value }

    func read() -> Int { result }
    #else
    var text = "value"

    init() {}

    var result: String { text }

    func read() -> String { result }
    #endif
  }
}
