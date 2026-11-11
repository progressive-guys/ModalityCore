// MARK: - Input
enum Examples {

  static func value() async throws -> Int {
    let value = try await load(
      1,
      2,
      3
    )


    return value
  }

  static func load(_ first: Int, _ second: Int, _ third: Int) async throws -> Int {
    first + second + third
  }
}

// MARK: - Output
enum Examples {

  static func value() async throws -> Int {
    let value = try await load(
      1,
      2,
      3
    )

    return value
  }

  static func load(_ first: Int, _ second: Int, _ third: Int) async throws -> Int {
    first + second + third
  }
}
