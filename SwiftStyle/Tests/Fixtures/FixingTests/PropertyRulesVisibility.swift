// MARK: - Input
public enum Examples {

  struct PublicAfterPrivate {

    private var a = 1
    public var b = 2
  }

  struct PublicAfterPrivateAcrossMethod {

    private var a = 1

    // Comment
    func function() {}

    public var b = 2
  }

  struct PrivateAfterFileprivate {

    fileprivate var a = 1
    private var b = 2
  }
}

// MARK: - Output
public enum Examples {

  struct PublicAfterPrivate {

    public var b : Int
    private var a : Int

    private init(a: Int = 1, b: Int = 2) {
      self.a = a
      self.b = b
    }
  }

  struct PublicAfterPrivateAcrossMethod {

    public var b : Int
    private var a : Int

    private init(a: Int = 1, b: Int = 2) {
      self.a = a
      self.b = b
    }

    // Comment
    func function() {}
  }

  struct PrivateAfterFileprivate {

    private var b : Int
    fileprivate var a : Int

    fileprivate init(a: Int = 1, b: Int = 2) {
      self.a = a
      self.b = b
    }
  }
}
