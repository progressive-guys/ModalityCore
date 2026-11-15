// MARK: - Удаление пустой строки в начале catch
func visit(_ action: () throws -> Void) {
  do {
    try action()
  } catch {

    print(error)
  }
}

/// Output
func visit(_ action: () throws -> Void) {
  do {
    try action()
  } catch {
    print(error)
  }
}

// MARK: - Удаление пустой строки после параметров замыкания
func visit() {
  let action = { (value: Int) in

    print(value)
    print("done")
  }
  action(1)
}

/// Output
func visit() {
  let action = { (value: Int) in
    print(value)
    print("done")
  }
  action(1)
}

// MARK: - Удаление пустой строки в начале замыкания без параметров
func visit() {
  let action = {

    print("first")
    print("second")
  }
  action()
}

/// Output
func visit() {
  let action = {
    print("first")
    print("second")
  }
  action()
}

// MARK: - Удаление пустой строки перед единственным комментарием функции
func empty() {

  // Empty body.
}

/// Output
func empty() {
  // Empty body.
}

// MARK: - Удаление пустой строки в начале вычисляемого свойства
var value: Int {

  1
}

/// Output
var value: Int {
  1
}

// MARK: - Удаление пустой строки в начале defer
func visit() {
  defer {

    print("done")
  }
}

/// Output
func visit() {
  defer {
    print("done")
  }
}

// MARK: - Удаление пустой строки в начале деинициализатора
final class Owner {
  deinit {

    print("released")
  }
}

/// Output
final class Owner {

  deinit {
    print("released")
  }
}

// MARK: - Удаление пустой строки в начале do
func visit(_ action: () throws -> Void) {
  do {

    try action()
  } catch {
    print(error)
  }
}

/// Output
func visit(_ action: () throws -> Void) {
  do {
    try action()
  } catch {
    print(error)
  }
}

// MARK: - Удаление пустой строки в начале else
func visit(_ value: Int) {
  if value > 0 {
    print(value)
  } else {

    print("other")
  }
}

/// Output
func visit(_ value: Int) {
  if value > 0 {
    print(value)
  } else {
    print("other")
  }
}

// MARK: - Удаление пустой строки в начале цикла for
func visit(_ values: [Int]) {
  for value in values {

    print(value)
  }
}

/// Output
func visit(_ values: [Int]) {
  for value in values {
    print(value)
  }
}

// MARK: - Удаление пустой строки в начале getter
var value: Int {
  get {

    return 1
  }
}

/// Output
var value: Int {
  get {
    return 1
  }
}

// MARK: - Удаление пустой строки в начале ветки else у guard
func visit(_ value: Int) {
  guard value > 0 else {

    print(value)
    return
  }
}

/// Output
func visit(_ value: Int) {
  guard value > 0 else {
    print(value)
    return
  }
}

// MARK: - Удаление пустой строки перед комментарием в начале if
func visit(_ value: Int) {
  if value > 0 {

    // Keep this comment.
    print(value)
  }
}

/// Output
func visit(_ value: Int) {
  if value > 0 {
    // Keep this comment.
    print(value)
  }
}

// MARK: - Удаление пустой строки в начале инициализатора
final class Owner {
  init() {

    print("created")
  }
}

/// Output
final class Owner {

  init() {
    print("created")
  }
}

// MARK: - Удаление пустой строки в начале repeat
func visit(_ values: inout [Int]) {
  repeat {

    print(values.popLast() as Any)
  } while !values.isEmpty
}

/// Output
func visit(_ values: inout [Int]) {
  repeat {
    print(values.popLast() as Any)
  } while !values.isEmpty
}

// MARK: - Удаление пустой строки в начале setter
var value: Int {
  get { 0 }
  set {

    print(newValue)
  }
}

/// Output
var value: Int {
  get { 0 }
  set {
    print(newValue)
  }
}

// MARK: - Удаление пустой строки перед первым вариантом switch
func value(_ input: Int) -> Int {
  switch input {

  case 0: return 0
  default: return 1
  }
}

/// Output
func value(_ input: Int) -> Int {
  switch input {
  case 0: return 0
  default: return 1
  }
}

// MARK: - Удаление пустой строки в начале while
func visit(_ values: inout [Int]) {
  while !values.isEmpty {

    print(values.removeLast())
  }
}

/// Output
func visit(_ values: inout [Int]) {
  while !values.isEmpty {
    print(values.removeLast())
  }
}
