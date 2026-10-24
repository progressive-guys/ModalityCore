// MARK: - Accepted

enum Accepted {
  static func example() {}
}
extension Accepted {
  static func outer() {
    func local() {}
    local()
  }
}

// MARK: - Rejected

enum Rejected {}

#if os(macOS)
@MainActor
func example() {}
#endif
func debugFatalError() {}
