// MARK: - Case CatchBody
// MARK: Input
func visit(_ action: () throws -> Void) {
  do {
    try action()
  } catch {

    print(error)
  }
}

// MARK: Output
func visit(_ action: () throws -> Void) {
  do {
    try action()
  } catch {
    print(error)
  }
}

// MARK: - Case ClosureWithParameters
// MARK: Input
func visit() {
  let action = { (value: Int) in

    print(value)
    print("done")
  }
  action(1)
}

// MARK: Output
func visit() {
  let action = { (value: Int) in
    print(value)
    print("done")
  }
  action(1)
}

// MARK: - Case ClosureWithoutSignature
// MARK: Input
func visit() {
  let action = {

    print("first")
    print("second")
  }
  action()
}

// MARK: Output
func visit() {
  let action = {
    print("first")
    print("second")
  }
  action()
}

// MARK: - Case CommentOnlyFunction
// MARK: Input
func empty() {

  // Empty body.
}

// MARK: Output
func empty() {
  // Empty body.
}

// MARK: - Case ComputedProperty
// MARK: Input
var value: Int {

  1
}

// MARK: Output
var value: Int {
  1
}

// MARK: - Case DeferBody
// MARK: Input
func visit() {
  defer {

    print("done")
  }
}

// MARK: Output
func visit() {
  defer {
    print("done")
  }
}

// MARK: - Case Deinitializer
// MARK: Input
final class Owner {
  deinit {

    print("released")
  }
}

// MARK: Output
final class Owner {
  deinit {
    print("released")
  }
}

// MARK: - Case DoBody
// MARK: Input
func visit(_ action: () throws -> Void) {
  do {

    try action()
  } catch {
    print(error)
  }
}

// MARK: Output
func visit(_ action: () throws -> Void) {
  do {
    try action()
  } catch {
    print(error)
  }
}

// MARK: - Case ElseBody
// MARK: Input
func visit(_ value: Int) {
  if value > 0 {
    print(value)
  } else {

    print("other")
  }
}

// MARK: Output
func visit(_ value: Int) {
  if value > 0 {
    print(value)
  } else {
    print("other")
  }
}

// MARK: - Case ForBody
// MARK: Input
func visit(_ values: [Int]) {
  for value in values {

    print(value)
  }
}

// MARK: Output
func visit(_ values: [Int]) {
  for value in values {
    print(value)
  }
}

// MARK: - Case Getter
// MARK: Input
var value: Int {
  get {

    return 1
  }
}

// MARK: Output
var value: Int {
  get {
    return 1
  }
}

// MARK: - Case GuardFailure
// MARK: Input
func visit(_ value: Int) {
  guard value > 0 else {

    print(value)
    return
  }
}

// MARK: Output
func visit(_ value: Int) {
  guard value > 0 else {
    print(value)
    return
  }
}

// MARK: - Case IfComment
// MARK: Input
func visit(_ value: Int) {
  if value > 0 {

    // Keep this comment.
    print(value)
  }
}

// MARK: Output
func visit(_ value: Int) {
  if value > 0 {
    // Keep this comment.
    print(value)
  }
}

// MARK: - Case Initializer
// MARK: Input
final class Owner {
  init() {

    print("created")
  }
}

// MARK: Output
final class Owner {
  init() {
    print("created")
  }
}

// MARK: - Case RepeatBody
// MARK: Input
func visit(_ values: inout [Int]) {
  repeat {

    print(values.popLast() as Any)
  } while !values.isEmpty
}

// MARK: Output
func visit(_ values: inout [Int]) {
  repeat {
    print(values.popLast() as Any)
  } while !values.isEmpty
}

// MARK: - Case Setter
// MARK: Input
var value: Int {
  get { 0 }
  set {

    print(newValue)
  }
}

// MARK: Output
var value: Int {
  get { 0 }
  set {
    print(newValue)
  }
}

// MARK: - Case SwitchBody
// MARK: Input
func value(_ input: Int) -> Int {
  switch input {

  case 0: return 0
  default: return 1
  }
}

// MARK: Output
func value(_ input: Int) -> Int {
  switch input {
  case 0: return 0
  default: return 1
  }
}

// MARK: - Case WhileBody
// MARK: Input
func visit(_ values: inout [Int]) {
  while !values.isEmpty {

    print(values.removeLast())
  }
}

// MARK: Output
func visit(_ values: inout [Int]) {
  while !values.isEmpty {
    print(values.removeLast())
  }
}
