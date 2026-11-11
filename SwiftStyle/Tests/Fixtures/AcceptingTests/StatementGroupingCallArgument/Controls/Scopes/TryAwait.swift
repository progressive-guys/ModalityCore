
enum Example {

  static func run(input: Int, load: () async throws -> Int, sink: (Int) -> Void) async throws {
    let value = try await load()
    let next = input
    let sum = value + next
    sink(sum)
  }
}
