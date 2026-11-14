// MARK: - Case AllowedDebugFatalError
func debugFatalError() {}

// MARK: - Case LocalFunctionInExtension
enum Examples {}

extension Examples {

  static func outer() {
    func local() {}
    local()
  }
}

// MARK: - Case StaticMemberFunction
enum Examples {
  static func example() {}
}
