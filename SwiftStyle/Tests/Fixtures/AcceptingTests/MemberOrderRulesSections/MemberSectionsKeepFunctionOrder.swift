enum Examples {

  final class Sections {

    lazy var cached = 1
    var observed = 0 { didSet {} }
    var callback: () -> Int = { 1 }

    init() {}

    deinit {}

    subscript(index: Int) -> Int { index }

    var longerName: String { "value" }
    var a: Int { 1 }

    private func longerMethod() -> Bool { true }
    public func b() {}
    static func c() {}
  }
}
