enum Example {

  static func run(input: Int, send: (Int) async throws -> Void, sink: (Int) -> Void) async throws {
    let value = input
    try await send(value)

    let next = value + 1
    sink(next)
  }
}
