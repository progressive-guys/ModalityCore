// MARK: - Input
public enum Examples {

  struct MissingGapBeforeLongGetter {

    func read() -> Int { 0 }
    var x: Int {
      let n = 1
      return n
    }
  }

  struct MissingGapAfterLongGetter {

    var x: Int {
      let n = 1
      return n
    }
    func read() -> Int { x }
  }

  struct MissingGapBetweenAccessors {

    var a: Int {
      get { 1 }
      set {}
    }
    var b: Int {
      get { 2 }
      set {}
    }
  }

  struct ExtraGapBetweenAccessors {

    var a: Int {
      get { 1 }
      set {}
    }


    var b: Int {
      get { 2 }
      set {}
    }
  }
}

// MARK: - Output
public enum Examples {

  struct MissingGapBeforeLongGetter {

    var x: Int {
      let n = 1
      return n
    }

    func read() -> Int { 0 }
  }

  struct MissingGapAfterLongGetter {

    var x: Int {
      let n = 1
      return n
    }

    func read() -> Int { x }
  }

  struct MissingGapBetweenAccessors {

    var a: Int {
      get { 1 }
      set {}
    }

    var b: Int {
      get { 2 }
      set {}
    }
  }

  struct ExtraGapBetweenAccessors {

    var a: Int {
      get { 1 }
      set {}
    }

    var b: Int {
      get { 2 }
      set {}
    }
  }
}
