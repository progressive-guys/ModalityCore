
enum Example {

  static func run(input: Int, other: Int, values: [Int], sink: (Int) -> Void) {
    let value = input
    let mapped = values.map { value in value + 1 }
    let next = other
    sink(mapped.count + value + next)
  }
}
