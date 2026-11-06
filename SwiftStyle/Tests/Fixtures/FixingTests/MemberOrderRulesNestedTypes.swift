// MARK: - Input
enum Examples {

  struct AliasAfterStorage {
    var value = 0
    typealias Value = Int
  }

  struct TypeAfterFunction {
    func read() {}
    struct Value {}
  }
}

// MARK: - Output
enum Examples {

  struct AliasAfterStorage {
    typealias Value = Int

    var value = 0
  }

  struct TypeAfterFunction {
    struct Value {}

    func read() {}
  }
}
