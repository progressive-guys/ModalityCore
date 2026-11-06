enum Examples {

  enum Failure: Error {
    case invalid
  }

  static func catchWhere() -> Bool {
    do {
      throw Failure.invalid
    } catch where String(describing: type(of: error)).isEmpty {
      return true
    } catch {
      return false
    }
  }
}
