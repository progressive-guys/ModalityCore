// MARK: - Case AdjacentAssignments
// MARK: Input
func configure(_ state: inout (displayLink: Int, callbackTarget: Int, isRunning: Bool, lastError: String?)) {
  state.displayLink = 1
  state.callbackTarget = 2

  state.isRunning = true
  state.lastError = nil
}

// MARK: Output
func configure(_ state: inout (displayLink: Int, callbackTarget: Int, isRunning: Bool, lastError: String?)) {
  state.displayLink = 1
  state.callbackTarget = 2
  state.isRunning = true
  state.lastError = nil
}

// MARK: - Case AssignmentSeriesOverridesStageReads
// MARK: Input
func configure(_ left: inout [Int], right: inout [Int]) {
  var first = [0]
  first.append(1)

  var second = [0]
  second.append(2)

  left = first

  right = first + second
}

// MARK: Output
func configure(_ left: inout [Int], right: inout [Int]) {
  var first = [0]
  first.append(1)

  var second = [0]
  second.append(2)

  left = first
  right = first + second
}

// MARK: - Case CallsBeforeAssignments
// MARK: Input
final class Node {

  var first = 0
  var second = 0

  func apply(_ value: Int) {}
  func render() {}
  func touch() {}
}

func run(node: Node) {
  node.touch()
  node.render()
  node.first = 1
  node.second = 2
}

// MARK: Output
final class Node {

  var first = 0
  var second = 0

  func apply(_ value: Int) {}
  func render() {}
  func touch() {}
}

func run(node: Node) {
  node.touch()
  node.render()

  node.first = 1
  node.second = 2
}

// MARK: - Case CaptureInitializerReadsLocal
// MARK: Input
func process(_ input: Int) {
  let value = input

  let completion = { [captured = value] in
    print(captured)
  }
  completion()
}

// MARK: Output
func process(_ input: Int) {
  let value = input
  let completion = { [captured = value] in
    print(captured)
  }
  completion()
}

// MARK: - Case ClosureBodyReadsPreparedLocal
// MARK: Input
func process(_ values: [Int], identifier: Int) {
  let requestID = identifier

  values.forEach { value in
    print(requestID, value)
  }
}

// MARK: Output
func process(_ values: [Int], identifier: Int) {
  let requestID = identifier
  values.forEach { value in
    print(requestID, value)
  }
}

// MARK: - Case ClosureContainingSwitchRead
// MARK: Input
func label(_ kind: Int, center: Int) {
  let angle = center + 90

  let completion = {
    switch kind {
    case 0: print("label", angle)
    default: print("circular", angle)
    }
  }
  completion()
}

// MARK: Output
func label(_ kind: Int, center: Int) {
  let angle = center + 90
  let completion = {
    switch kind {
    case 0: print("label", angle)
    default: print("circular", angle)
    }
  }
  completion()
}

// MARK: - Case ClosureDeclarationThenArgument
// MARK: Input
func process(_ values: [Int]) {
  let completion: (Int) -> Void = { value in
    print(value)
  }

  values.forEach(completion)
}

// MARK: Output
func process(_ values: [Int]) {
  let completion: (Int) -> Void = { value in
    print(value)
  }
  values.forEach(completion)
}

// MARK: - Case ClosureDeclarationThenCallee
// MARK: Input
func run(input: Int, other: Int, sink: @escaping (Int) -> Void) {
  let callback: () -> Void = {
    sink(input)
  }
  callback()
}

// MARK: Output
func run(input: Int, other: Int, sink: @escaping (Int) -> Void) {
  let callback: () -> Void = {
    sink(input)
  }

  callback()
}

// MARK: - Case ConditionalMutationOfPreparedLocal
// MARK: Input
func headers(_ extra: [String]) -> [String] {
  var fields = ["default"]

  if !extra.isEmpty {
    fields.append(contentsOf: extra)
  }
  return fields
}

// MARK: Output
func headers(_ extra: [String]) -> [String] {
  var fields = ["default"]
  if !extra.isEmpty {
    fields.append(contentsOf: extra)
  }
  return fields
}

// MARK: - Case ElseReadsOuterBinding
// MARK: Input
func process(_ input: Int?, alternative: Int?) {
  let value = input

  if let value = alternative {
    print(value)
  } else {
    print(value as Any)
  }
}

// MARK: Output
func process(_ input: Int?, alternative: Int?) {
  let value = input
  if let value = alternative {
    print(value)
  } else {
    print(value as Any)
  }
}

// MARK: - Case ExpressionPatternReadsLocal
// MARK: Input
func process(_ input: Int, candidate: Int) {
  let value = input

  if case value = candidate {
    print("matched")
  }
}

// MARK: Output
func process(_ input: Int, candidate: Int) {
  let value = input
  if case value = candidate {
    print("matched")
  }
}

// MARK: - Case GuardBindingContinuesGroup
// MARK: Input
func process(_ input: Int?) {
  let candidate = input

  guard let value = candidate else { return }
  print(value)
  print(value + 1)
}

// MARK: Output
func process(_ input: Int?) {
  let candidate = input
  guard let value = candidate else { return }
  print(value)
  print(value + 1)
}

// MARK: - Case GuardFailureReadsPreparedLocal
// MARK: Input
func process(_ input: Int, enabled: Bool) {
  let value = input

  guard enabled else {
    print(value)
    return
  }
  print(value)
}

// MARK: Output
func process(_ input: Int, enabled: Bool) {
  let value = input
  guard enabled else {
    print(value)
    return
  }

  print(value)
}

// MARK: - Case IfBodyReadsPreparedLocal
// MARK: Input
func play(_ input: Int, high: Bool) {
  let volume = input

  if high {
    print(volume)
  } else {
    print(-volume)
  }
}

// MARK: Output
func play(_ input: Int, high: Bool) {
  let volume = input
  if high {
    print(volume)
  } else {
    print(-volume)
  }
}

// MARK: - Case IndependentActionBeforeFinalReturn
// MARK: Input
enum Examples {

  static func value() -> String {
    let value = String(
      repeating: "a",
      count: 2
    )
    print("done")
    return value
  }
}

// MARK: Output
enum Examples {

  static func value() -> String {
    let value = String(
      repeating: "a",
      count: 2
    )

    print("done")

    return value
  }
}

// MARK: - Case InlineChecksBeforeReturn
// MARK: Input
func missingGapBeforeReturn(_ x: Int) -> Int {
  if x == 0 { return 0 }
  if x < 0 { return -1 }
  if x == 1 { return 1 }
  return x
}

// MARK: Output
func missingGapBeforeReturn(_ x: Int) -> Int {
  if x == 0 { return 0 }
  if x < 0 { return -1 }
  if x == 1 { return 1 }

  return x
}

// MARK: - Case LocalUsedAsForSequence
// MARK: Input
func process(_ input: [Int]) {
  let values = input

  for value in values {
    print(value)
  }
}

// MARK: Output
func process(_ input: [Int]) {
  let values = input
  for value in values {
    print(value)
  }
}

// MARK: - Case MixedMultilineChecks
// MARK: Input
func check(_ value: Int) {
  guard value > 0 else { return }
  if value == 1 {
    return
  }
  guard value < 10 else { return }
}

// MARK: Output
func check(_ value: Int) {
  guard value > 0 else { return }

  if value == 1 {
    return
  }

  guard value < 10 else { return }
}

// MARK: - Case MultilineExpressionsExcessGap
// MARK: Input
func process(_ input: Int) {
  let value = max(
    input,
    0
  )


  print(
    value,
    value + 1
  )
}

// MARK: Output
func process(_ input: Int) {
  let value = max(
    input,
    0
  )

  print(
    value,
    value + 1
  )
}

// MARK: - Case NamedCatchReadsOuterError
// MARK: Input

func process(_ input: Int) {
  let error = input

  do {
    throw NSError(domain: "test", code: 0)
  } catch let failure {
    print(error, failure)
  }
}

// MARK: Output

func process(_ input: Int) {
  let error = input
  do {
    throw NSError(domain: "test", code: 0)
  } catch let failure {
    print(error, failure)
  }
}

// MARK: - Case OrdinaryActionsExcessGap
// MARK: Input
func update(_ input: Int, first: inout [Int], second: inout [Int]) {
  let value = input
  first.append(value)


  second.removeAll()
  first.sort()
}

// MARK: Output
func update(_ input: Int, first: inout [Int], second: inout [Int]) {
  let value = input
  first.append(value)

  second.removeAll()
  first.sort()
}

// MARK: - Case PreparedLocalsOverrideCheckGaps
// MARK: Input
func declarationsThenChecksAndReturn() -> Int {
  let a = 1
  let b = 2

  if a == b { return a }

  if b > a {
    return b
  }

  return a
}

// MARK: Output
func declarationsThenChecksAndReturn() -> Int {
  let a = 1
  let b = 2
  if a == b { return a }
  if b > a {
    return b
  }
  return a
}

// MARK: - Case PreparedLocalsUsedByCalls
// MARK: Input
func process(_ input: Int) {
  let first = input
  let second = input + 1

  print(first)
  print(second)
}

// MARK: Output
func process(_ input: Int) {
  let first = input
  let second = input + 1
  print(first)
  print(second)
}

// MARK: - Case ShortDeclarationMultilineConsumer
// MARK: Input
func process(_ input: Int) {
  let value = input

  print(
    value,
    value + 1
  )
}

// MARK: Output
func process(_ input: Int) {
  let value = input
  print(
    value,
    value + 1
  )
}

// MARK: - Case SwitchBodyReadDoesNotJoin
// MARK: Input
func label(_ kind: Int, center: Int) {
  let angle = center + 90
  switch kind {
  case 0:
    print("label", angle)

  default:
    print("circular", angle)
  }
}

// MARK: Output
func label(_ kind: Int, center: Int) {
  let angle = center + 90

  switch kind {
  case 0:
    print("label", angle)

  default:
    print("circular", angle)
  }
}

// MARK: - Case SwitchSubjectReadsLocal
// MARK: Input
func process(_ input: Int) {
  let value = input

  switch value {
  case 0: print("zero")
  default: print(value)
  }
}

// MARK: Output
func process(_ input: Int) {
  let value = input
  switch value {
  case 0: print("zero")
  default: print(value)
  }
}

// MARK: - Case TallCallBeforeReturn
// MARK: Input

func value() -> String {
  let value = "a".replacingOccurrences(
    of: "a",
    with: "b",
    options: .literal,
    range: nil
  )
  return value
}

// MARK: Output

func value() -> String {
  let value = "a".replacingOccurrences(
    of: "a",
    with: "b",
    options: .literal,
    range: nil
  )

  return value
}

// MARK: - Case ThreeOrdinaryActions
// MARK: Input
func update(_ first: inout [Int], second: inout [Int]) {
  first.removeAll()

  second.sort()

  first.append(0)
}

// MARK: Output
func update(_ first: inout [Int], second: inout [Int]) {
  first.removeAll()
  second.sort()
  first.append(0)
}

// MARK: - Case TupleLocalsUsedByCalls
// MARK: Input
func process(_ input: (Int, Int)) {
  let (first, second) = input

  print(first)
  print(second)
  print(first + second)
}

// MARK: Output
func process(_ input: (Int, Int)) {
  let (first, second) = input
  print(first)
  print(second)
  print(first + second)
}

// MARK: - Case WeakCaptureWithShorthandBinding
// MARK: Input

enum Examples {

  static func process(_ input: NSObject) {
    let object = input

    let completion = { [weak object] in
      guard let object else { return }
      print(object)
    }
    completion()
  }
}

// MARK: Output

enum Examples {

  static func process(_ input: NSObject) {
    let object = input
    let completion = { [weak object] in
      guard let object else { return }
      print(object)
    }
    completion()
  }
}
