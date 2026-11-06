// MARK: - Input
enum Examples {

  struct StoredAfterConditionalGetter {
    init() {}
    #if os(macOS)
    var displayed: Int { 1 }
    #else
    var displayed: String { "value" }
    #endif
    var isImporting = false
  }

  struct FunctionBeforeConditionalGetter {
    func read() -> Int { 0 }
    #if os(macOS)
    #if DEBUG
    var displayed: Int { 1 }
    #else
    var displayed: Int { 2 }
    #endif
    #endif
  }

  struct ConditionalBranch {
    #if os(macOS)
    func read() -> Int { value }
    var value: Int { 1 }
    #else
    func read() -> Int { value }
    var value: Int { 2 }
    #endif
  }

  struct FunctionBeforeConditionalSubscript {
    func read() {}
    #if os(macOS)
    subscript(index: Int) -> Int { index }
    #else
    subscript(index: Int) -> Int { index + 1 }
    #endif
  }
}

// MARK: - Output
enum Examples {

  struct StoredAfterConditionalGetter {

    var isImporting = false

    init() {}
    #if os(macOS)
    var displayed: Int { 1 }
    #else
    var displayed: String { "value" }
    #endif
  }

  struct FunctionBeforeConditionalGetter {

    #if os(macOS)
    #if DEBUG
    var displayed: Int { 1 }
    #else
    var displayed: Int { 2 }
    #endif
    #endif
    func read() -> Int { 0 }
  }

  struct ConditionalBranch {

    #if os(macOS)
    var value: Int { 1 }

    func read() -> Int { value }
    #else
    var value: Int { 2 }

    func read() -> Int { value }
    #endif
  }

  struct FunctionBeforeConditionalSubscript {

    #if os(macOS)
    subscript(index: Int) -> Int { index }
    #else
    subscript(index: Int) -> Int { index + 1 }
    #endif
    func read() {}
  }
}
