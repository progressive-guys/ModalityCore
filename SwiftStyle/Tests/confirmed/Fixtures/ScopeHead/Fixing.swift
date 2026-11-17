// MARK: - Пустая строка в начале catch и замыканий удаляется
func catchBody(_ action: () throws -> Void) {
  do {
    try action()
  } catch {

    print(error)
  }
}

func closureParameters() {
  let action = { (value: Int) in

    print(value)
    print("done")
  }
  action(1)
}

func closureBody() {
  let action = {

    print("first")
    print("second")
  }
  action()
}

/// Output
func catchBody(_ action: () throws -> Void) {
  do {
    try action()
  } catch {
    print(error)
  }
}

func closureParameters() {
  let action = { (value: Int) in
    print(value)
    print("done")
  }
  action(1)
}

func closureBody() {
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

// MARK: - Удаление пустых строк в начале вычисляемого свойства и аксессоров
enum Accessors {

  static var implicit: Int {

    1
  }

  static var explicit: Int {
    get {

      return 1
    }
  }

  static var mutable: Int {
    get { 0 }
    set {

      print(newValue)
    }
  }
}

/// Output
enum Accessors {

  static var implicit: Int {
    1
  }

  static var explicit: Int {
    get {
      return 1
    }
  }

  static var mutable: Int {
    get { 0 }
    set {
      print(newValue)
    }
  }
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

// MARK: - Удаление пустых строк в начале init и deinit
final class Owner {

  init() {

    print("created")
  }

  deinit {

    print("released")
  }
}

/// Output
final class Owner {

  init() {
    print("created")
  }

  deinit {
    print("released")
  }
}

// MARK: - Пустая строка в начале do, else и for удаляется
func doBody(_ action: () throws -> Void) {
  do {

    try action()
  } catch {
    print(error)
  }
}

func elseBody(_ value: Int) {
  if value > 0 {
    print(value)
  } else {

    print("other")
  }
}

func forBody(_ values: [Int]) {
  for value in values {

    print(value)
  }
}

/// Output
func doBody(_ action: () throws -> Void) {
  do {
    try action()
  } catch {
    print(error)
  }
}

func elseBody(_ value: Int) {
  if value > 0 {
    print(value)
  } else {
    print("other")
  }
}

func forBody(_ values: [Int]) {
  for value in values {
    print(value)
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

// MARK: - Удаление пустых строк в начале repeat и while
enum Loops {

  static func repeatBody(_ values: inout [Int]) {
    repeat {

      print(values.popLast() as Any)
    } while !values.isEmpty
  }

  static func whileBody(_ values: inout [Int]) {
    while !values.isEmpty {

      print(values.removeLast())
    }
  }
}

/// Output
enum Loops {

  static func repeatBody(_ values: inout [Int]) {
    repeat {
      print(values.popLast() as Any)
    } while !values.isEmpty
  }

  static func whileBody(_ values: inout [Int]) {
    while !values.isEmpty {
      print(values.removeLast())
    }
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
