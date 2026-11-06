// MARK: - Input
enum Examples {

  struct ExtraFunctionGap {

    func a() -> Int { 1 }

    func b() -> Int { 2 }
  }

  struct MultilineMethod {

    func a() -> Int {
      1
    }
    func b() -> Int { 2 }
  }

  struct GetterBeforeMethod {

    var x: Int {
      1
    }
    func read() -> Int { x }
  }
}

extension Examples {

  static func extendedFirst() -> Int { 1 }

  static func extendedSecond() -> Int { 2 }
}

// MARK: - Output
enum Examples {

  struct ExtraFunctionGap {
    func a() -> Int { 1 }
    func b() -> Int { 2 }
  }

  struct MultilineMethod {

    func a() -> Int {
      1
    }

    func b() -> Int { 2 }
  }

  struct GetterBeforeMethod {

    var x: Int {
      1
    }

    func read() -> Int { x }
  }
}

extension Examples {
  static func extendedFirst() -> Int { 1 }
  static func extendedSecond() -> Int { 2 }
}
