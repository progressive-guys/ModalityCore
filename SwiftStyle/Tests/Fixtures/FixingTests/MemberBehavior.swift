// MARK: - Input
@propertyWrapper
struct Box<T> {
  var wrappedValue: T
}

struct Wrapped {
  func read() -> Int { longerName + x }

  var result: Int { read() }

  @Box var longerName: Int
  @Box var x: Int

  init(longerName: Int, x: Int) {
    self.longerName = longerName
    self.x = x
  }
}

let wrapped = Wrapped(longerName: 2, x: 3)

@MainActor
final class Owner {
  static var events: [String] = []

  func read() -> Int { result }

  var result: Int { first + second }

  init() { Self.events.append("init") }

  var first: Int = Owner.record("first")
  var second: Int = Owner.record("second") { didSet { Self.events.append("observer") } }

  static func record(_ event: String) -> Int {
    events.append(event)
    return events.count
  }
}

let owner = Owner()
owner.second = 5

// MARK: - Output
@propertyWrapper
struct Box<T> {
  var wrappedValue: T
}

struct Wrapped {

  @Box var x: Int
  @Box var longerName: Int

  init(longerName: Int, x: Int) {
    self.longerName = longerName
    self.x = x
  }

  var result: Int { read() }

  func read() -> Int { longerName + x }
}

let wrapped = Wrapped(longerName: 2, x: 3)

@MainActor
final class Owner {

  static var events: [String] = []
  var first: Int = Owner.record("first")
  var second: Int = Owner.record("second") { didSet { Self.events.append("observer") } }

  init() { Self.events.append("init") }

  var result: Int { first + second }

  func read() -> Int { result }

  static func record(_ event: String) -> Int {
    events.append(event)
    return events.count
  }
}

let owner = Owner()
owner.second = 5
