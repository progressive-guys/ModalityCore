// MARK: - Input
enum Examples {

  protocol P {

    associatedtype U

    associatedtype O

    var a: Int { get }
    var b: Int { get }

    func start()

    func stop()

    init()

    init(x: Int)

    subscript(j: Int) -> Int { get }

    subscript(n: String) -> Int { get }
  }

  protocol Q {

    func a(
      x: Int
    )
    func b()
  }
}

// MARK: - Output
enum Examples {

  protocol P {

    associatedtype U
    associatedtype O

    init()
    init(x: Int)

    subscript(j: Int) -> Int { get }
    subscript(n: String) -> Int { get }

    var a: Int { get }
    var b: Int { get }

    func start()
    func stop()
  }

  protocol Q {

    func a(
      x: Int
    )

    func b()
  }
}
