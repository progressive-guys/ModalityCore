
enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    var first = [input]
    first.append(1)

    var second = [other]
    second.append(2)

    sink(first.count + second.count)
  }
}
