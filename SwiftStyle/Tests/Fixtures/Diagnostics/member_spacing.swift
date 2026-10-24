// MARK: - Accepted

enum Accepted {

  struct DifferentKinds {

    var a = 1

    func read() -> Int { a }

    init() {}
  }

  struct Methods {

    func a() -> Int { 1 }
    func b() -> Int { 2 }

    func c() -> Int {
      3
    }
  }

  struct SeparatedTypes {

    struct First {}

    struct Second {}
  }

  struct GetterBeforeMethod {

    var x: Int {
      1
    }

    func read() -> Int { x }
  }

  static func localStatements() -> Int {
    let a = 1
    let b = 2

    if a == b { return a }
    if b > a {
      return b
    }

    return a
  }

  protocol P {

    associatedtype U
    associatedtype O

    var a: Int { get }
    var b: Int { get set }

    func start()
    func stop()

    init()
    init(x: Int)

    subscript(j: Int) -> Int { get }
    subscript(n: String) -> Int { get }
  }
}

// MARK: - Rejected

enum Rejected {

  struct CompactMethodGap {

    func a() -> Int { 1 }

    func b() -> Int { 2 }
  }

  struct MultilineMethod {

    func a() -> Int {
      1
    }
    func b() -> Int { 2 }
  }

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

  struct GetterBeforeMethod {

    var x: Int {
      1
    }
    func read() -> Int { x }
  }

  struct MissingOpeningGap {
    var x = 1
  }

  struct MissingOpeningGapBeforeComment {
    // Initial value.
    var x = 1
  }

  protocol Q {

    func a(
      x: Int
    )
    func b()
  }
}

extension Rejected {

  static func extendedFirst() -> Int { 1 }

  static func extendedSecond() -> Int { 2 }
}
