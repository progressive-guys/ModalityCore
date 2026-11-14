// MARK: - Case ArgumentIsReference
func log(message: Int) {}

func run(input: Int, sink: (Int) -> Void) {
  let value = input
  log(message: value)

  let next = value + 1
  sink(next)
}

// MARK: - Case ByValueBesideInout
func pair(_ other: inout Int, _ value: Int) {}

func run(input: Int, sink: (Int) -> Void) {
  var other = 0
  let value = input
  pair(&other, value)

  let next = value + 1
  sink(next)
}

// MARK: - Case DependencySurvivesManualGap
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)

    let next = abs(value)
    let sum = next + value
    sink(sum)
  }
}

// MARK: - Case ExplicitCaptureArgument
func run(input: Int, visit: (() -> Int) -> Void, sink: (Int) -> Void) {
  let value = input
  visit { [copy = value] in copy }

  let next = value + 1
  sink(next)
}

// MARK: - Case ExplicitCaptureInitializer
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let next = { [copy = value] in copy + 1 }
  sink(next())
}

// MARK: - Case InterpolationReadsLocal
func run(input: Int, say: (String) -> Void, sink: (Int) -> Void) {
  let value = input
  say("\(value)")

  let next = value + 1
  sink(next)
}

// MARK: - Case NestedCalleeInsideArgument
func run(input: Int, sink: (Int) -> Void) {
  let value: (Int) -> Int = abs
  sink(value(input))

  let next = value(input + 1)
  sink(next)
}

// MARK: - Case NestedReceiverInsideArgument
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value.distance(to: input))

  let next = value + 1
  sink(next)
}

// MARK: - Case OuterScopeLocal
func run(input: Int, sink: @escaping (Int) -> Void) {
  let value = input
  let visit = {
    sink(value)

    let next = value + 1
    sink(next)
    sink(next)
  }

  visit()
}

// MARK: - Case ParameterCanAnchorManualGap
func run(input: Int, sink: (Int) -> Void) {
  let preceding = input
  sink(preceding)
  sink(input)

  let next = input + 1
  sink(next)
}
