infix operator ||=
extension Bool {
  public static func ||= (lhs: inout Bool, rhs: @autoclosure () -> Bool) {
    lhs = (lhs || rhs())
  }
}

infix operator &&=
extension Bool {
  public static func &&= (lhs: inout Bool, rhs: @autoclosure () -> Bool) {
    lhs = (lhs && rhs())
  }
}

infix operator ??=
extension Optional {
  public static func ??=(lhs: inout Self, rhs: @autoclosure () -> Wrapped) {
    if lhs == nil {
      lhs = rhs()
    }
  }
}
