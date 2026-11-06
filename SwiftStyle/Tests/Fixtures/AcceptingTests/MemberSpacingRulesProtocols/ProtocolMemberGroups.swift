enum Examples {

  protocol P {

    associatedtype U
    associatedtype O

    init()
    init(x: Int)

    subscript(j: Int) -> Int { get }
    subscript(n: String) -> Int { get }

    var a: Int { get }
    var b: Int { get set }

    func start()
    func stop()
  }
}
