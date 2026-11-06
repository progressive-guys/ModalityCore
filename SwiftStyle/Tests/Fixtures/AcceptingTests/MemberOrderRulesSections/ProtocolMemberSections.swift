enum Examples {

  protocol Requirements {

    init()

    subscript(index: Int) -> Int { get }

    var writable: Int { get set }
    var readOnly: String { get }

    func longerName()
    func a()
  }
}
