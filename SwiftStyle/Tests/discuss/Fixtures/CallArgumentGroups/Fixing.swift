// MARK: - Case CalleeIsNotArgument
// MARK: Input
func run(input: Int, sink: (Int) -> Void) {
  let value = sink
  value(input)

  let next = value
  next(input)
}

// MARK: Output
func run(input: Int, sink: (Int) -> Void) {
  let value = sink
  value(input)
  let next = value
  next(input)
}

// MARK: - Case ClosureBodyArgument
// MARK: Input
func run(input: Int, visit: (() -> Int) -> Void, sink: (Int) -> Void) {
  let value = input
  visit { value }
  let next = value + 1
  sink(next)
}

// MARK: Output
func run(input: Int, visit: (() -> Int) -> Void, sink: (Int) -> Void) {
  let value = input
  visit { value }
  
  let next = value + 1
  sink(next)
}

// MARK: - Case ClosureBodyInitializer
// MARK: Input
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let next = { value + 1 }
  sink(next())
}

// MARK: Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  let next = { value + 1 }
  sink(next())
}

// MARK: - Case ComputedLocalIsNotInitializer
// MARK: Input
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  var next: Int { value + 1 }
  sink(next)
}

// MARK: Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  var next: Int { value + 1 }
  sink(next)
}

// MARK: - Case GuardAfterCompletedCallStage
// MARK: Input
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)
    guard value > 0 else { return }
    sink(value)
  }
}

// MARK: Output
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)

    guard value > 0 else { return }
    sink(value)
  }
}

// MARK: - Case IfAfterCompletedCallStage
// MARK: Input
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)
    if value > 0 {
      sink(value)
    }

    sink(input)
  }
}

// MARK: Output
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)

    if value > 0 {
      sink(value)
    }

    sink(input)
  }
}

// MARK: - Case IfExpressionInitializer
// MARK: Input
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let next = if input > 0 {
    value
  } else {
    0
  }
  sink(next)
}

// MARK: Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  let next = if input > 0 {
    value
  } else {
    0
  }

  sink(next)
}

// MARK: - Case IndependentNextStage
// MARK: Input
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  let next = input + 1
  sink(next)
}

// MARK: Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let next = input + 1
  sink(next)
}

// MARK: - Case InitializerReadsTwoGroups
// MARK: Input
func run(input: Int, sink: (Int) -> Void) {
  let first = input
  sink(first)

  let second = input + 1
  sink(second)
  let next = second + first
  sink(next)
}

// MARK: Output
func run(input: Int, sink: (Int) -> Void) {
  let first = input
  sink(first)

  let second = input + 1
  sink(second)

  let next = second + first
  sink(next)
}

// MARK: - Case InoutIsNotByValueRead
// MARK: Input
func touch(_ value: inout Int) { value += 1 }

func run(input: Int, sink: (Int) -> Void) {
  var value = input
  touch(&value)

  let next = value + 1
  sink(next)
}

// MARK: Output
func touch(_ value: inout Int) { value += 1 }

func run(input: Int, sink: (Int) -> Void) {
  var value = input
  touch(&value)
  let next = value + 1
  sink(next)
}

// MARK: - Case KeyPathComponentIsNotReference
// MARK: Input
struct Box {
  let value: Int }

func log(_ path: KeyPath<Box, Int>, _ value: Int) {}

func run(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input
  log(\Box.value, other)

  let next = value + 1
  sink(next)
}

// MARK: Output
struct Box {
  let value: Int }

func log(_ path: KeyPath<Box, Int>, _ value: Int) {}

func run(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input
  log(\Box.value, other)
  let next = value + 1
  sink(next)
}

// MARK: - Case LabelIsNotReference
// MARK: Input
func log(value: Int) {}

func run(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input
  log(value: other)

  let next = value + 1
  sink(next)
}

// MARK: Output
func log(value: Int) {}

func run(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input
  log(value: other)
  let next = value + 1
  sink(next)
}

// MARK: - Case LeadingCommentBarrier
// MARK: Input
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  // Next calculation.
  let next = abs(value)
  sink(next)
}

// MARK: Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  // Next calculation.
  let next = abs(value)
  sink(next)
}

// MARK: - Case MemberNameIsNotReference
// MARK: Input
struct Box {
  let value: Int }

func pair(_ a: Int, _ b: Int) {}

func run(input: Int, box: Box, sink: (Int) -> Void) {
  let value = input
  let other = input
  pair(box.value, other)

  let next = value + 1
  sink(next)
}

// MARK: Output
struct Box {
  let value: Int }

func pair(_ a: Int, _ b: Int) {}

func run(input: Int, box: Box, sink: (Int) -> Void) {
  let value = input
  let other = input
  pair(box.value, other)
  let next = value + 1
  sink(next)
}

// MARK: - Case MultilineDerivedInitializer
// MARK: Input
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)

    let next = abs(
      value
    )

    sink(next)
  }
}

// MARK: Output
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)
    let next = abs(
      value
    )

    sink(next)
  }
}

// MARK: - Case MultilinePreviousCall
// MARK: Input
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(
    value
  )

  let next = value + 1
  sink(next)
}

// MARK: Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(
    value
  )
  let next = value + 1
  sink(next)
}

// MARK: - Case MultipleBindings
// MARK: Input
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let next = value, ignored = input
  sink(next + ignored)
}

// MARK: Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  let next = value, ignored = input
  sink(next + ignored)
}

// MARK: - Case NoAliasExpansion
// MARK: Input
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  let alias = value
  sink(alias)

  let next = abs(value)
  sink(next)
}

// MARK: Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  let alias = value
  sink(alias)
  let next = abs(value)
  sink(next)
}

// MARK: - Case NormalizeExcessGap
// MARK: Input
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)


  let next = value + 1
  sink(next)
}

// MARK: Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let next = value + 1
  sink(next)
}

// MARK: - Case OnlyImmediatelyPreviousCall
// MARK: Input
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input + 1
  sink(value)
  sink(other)

  let next = value + 1
  sink(next)
}

// MARK: Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input + 1
  sink(value)
  sink(other)
  let next = value + 1
  sink(next)
}

// MARK: - Case ReceiverIsNotArgument
// MARK: Input
func run(input: Int, sink: (Int) -> Void) {
  var value: [Int] = []
  value.append(input)

  let next = value.count
  sink(next)
}

// MARK: Output
func run(input: Int, sink: (Int) -> Void) {
  var value: [Int] = []
  value.append(input)
  let next = value.count
  sink(next)
}

// MARK: - Case ReturnIsNotNewDeclaration
// MARK: Input
func run(input: Int, sink: (Int) -> Void) -> Int {
  let value = input
  let copy = value + 1
  sink(copy)

  return abs(copy)
}

// MARK: Output
func run(input: Int, sink: (Int) -> Void) -> Int {
  let value = input
  let copy = value + 1
  sink(copy)
  return abs(copy)
}

// MARK: - Case ShadowedArgumentClosure
// MARK: Input
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input
  sink([other].map { value in value }.count)

  let next = value + 1
  sink(next)
}

// MARK: Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input
  sink([other].map { value in value }.count)
  let next = value + 1
  sink(next)
}

// MARK: - Case ThreeStatementBody
// MARK: Input
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let next = abs(value)
}

// MARK: Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  let next = abs(value)
}

// MARK: - Case TuplePatternDeclaration
// MARK: Input
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let (next, _) = (value, input)
  sink(next)
}

// MARK: Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  let (next, _) = (value, input)
  sink(next)
}
