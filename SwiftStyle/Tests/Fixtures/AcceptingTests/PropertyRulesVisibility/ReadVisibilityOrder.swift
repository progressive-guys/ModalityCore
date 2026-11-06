public enum Examples {

  open class ReadVisibilityOrder {

    public var b = 2
    var c = 3
    private var d = 4
    fileprivate var e = 5

    open var a: Int { 1 }
  }
}
