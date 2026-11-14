// MARK: - Case CommentedDeclaration
// MARK: Input
func run(input: Int, other: Int, sink: (Int) -> Void) {
  let value = input
  // Prepare another value.
  let next = other
  let sum = value + next
  sink(sum)
}

// MARK: Output
func run(input: Int, other: Int, sink: (Int) -> Void) {
  let value = input

  // Prepare another value.
  let next = other

  let sum = value + next
  sink(sum)
}

// MARK: - Case ConsumerOfTwoPreparedGroups
// MARK: Input
func run(input: Int, other: Int, sink: (Int) -> Void) {
  var first = [input]
  first.append(1)

  var second = [other]
  second.append(2)
  sink(first.count + second.count)
}

// MARK: Output
func run(input: Int, other: Int, sink: (Int) -> Void) {
  var first = [input]
  first.append(1)

  var second = [other]
  second.append(2)

  sink(first.count + second.count)
}

// MARK: - Case EarlierLocalInDeclarationGroup
// MARK: Input
func run(input: Int, other: Int, sink: (Int) -> Void) {
  let base = input
  let count = other
  let scaled = base * 2

  let width = other + 1
  sink(scaled + count + width)
}

// MARK: Output
func run(input: Int, other: Int, sink: (Int) -> Void) {
  let base = input
  let count = other
  let scaled = base * 2

  let width = other + 1

  sink(scaled + count + width)
}

// MARK: - Case IndependentBetweenDependentStages
// MARK: Input
func run(input: Int, other: Int, sink: (Int) -> Void) {
  let base = input
  let scaled = base * 2
  let count = other
  let spacing = scaled / max(count, 1)
  sink(spacing)
}

// MARK: Output
func run(input: Int, other: Int, sink: (Int) -> Void) {
  let base = input
  let scaled = base * 2

  let count = other

  let spacing = scaled / max(count, 1)
  sink(spacing)
}

// MARK: - Case IndependentBindingsJoinSharedUse
// MARK: Input
func run(input: Int, other: Int, sink: (Int) -> Void) {
  let first = input

  let second = other
  let sum = first + second
  sink(sum)
}

// MARK: Output
func run(input: Int, other: Int, sink: (Int) -> Void) {
  let first = input
  let second = other
  let sum = first + second
  sink(sum)
}

// MARK: - Case ReturnReadsPreparedGroups
// MARK: Input
func run(input: Int, other: Int) -> Int {
  let value = input
  let scaled = value * 2
  let count = other
  return scaled + count
}

// MARK: Output
func run(input: Int, other: Int) -> Int {
  let value = input
  let scaled = value * 2

  let count = other

  return scaled + count
}

// MARK: - Case SeparateObjectConfigurations
// MARK: Input
final class Node {

  var first = 0
  var second = 0

  func apply(_ value: Int) {}
  func render() {}
  func touch() {}
}

func run(input: Int) {
  let first = Node()
  first.first = input
  first.render()
  let second = Node()
  second.first = input
  second.render()
}

// MARK: Output
final class Node {

  var first = 0
  var second = 0

  func apply(_ value: Int) {}
  func render() {}
  func touch() {}
}

func run(input: Int) {
  let first = Node()
  first.first = input
  first.render()

  let second = Node()
  second.first = input
  second.render()
}
