
enum Example {

  static func run(input: Int?, sink: (Int) -> Void) {
    guard let value = input else { return }
    sink(value)
  }
}
