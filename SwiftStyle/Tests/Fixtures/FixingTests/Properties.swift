// MARK: - Input
var events: [String] = []
let record: @MainActor (String) -> Int = { name in events.append(name); return 1 }
@MainActor
struct Values {
  // Private value.
  private var privateValue: Int = record("private")

  func read() -> Int { publicValue + privateValue }

  // Public value.
  public var publicValue: Int = record("public")

  init() {}
}
let values = Values()
struct Memberwise {
  let first: Int
  let text: String
  let last: Int
}
let memberwise = Memberwise(first: 1, text: "two", last: 3)

@MainActor
struct Defaults {
  var first: Int = record("first")
  var text: String = "two"
  var last: Int = record("last")
}
events = []
let supplied = Defaults(first: 5, text: "six", last: 7)
events = []
let defaults = Defaults()

struct AttributedComputed {
  let longerName: Int
  let x: String
  @MainActor var value: Int { longerName }
}
let attributed = AttributedComputed(longerName: 1, x: "two")

// MARK: - Output
var events: [String] = []
let record: @MainActor (String) -> Int = { name in events.append(name); return 1 }
@MainActor
struct Values {

  // Public value.
  public var publicValue: Int = record("public")

  // Private value.
  private var privateValue: Int = record("private")

  init() {}

  func read() -> Int { publicValue + privateValue }
}
let values = Values()
struct Memberwise {

  let last: Int
  let first: Int
  let text: String

  init(first: Int, text: String, last: Int) {
    self.first = first
    self.text = text
    self.last = last
  }
}
let memberwise = Memberwise(first: 1, text: "two", last: 3)

@MainActor
struct Defaults {

  var last: Int 
  var first: Int 
  var text: String 

  init(first: Int = record("first"), text: String = "two", last: Int = record("last")) {
    self.first = first
    self.text = text
    self.last = last
  }
}
events = []
let supplied = Defaults(first: 5, text: "six", last: 7)
events = []
let defaults = Defaults()

struct AttributedComputed {

  let x: String
  let longerName: Int

  init(longerName: Int, x: String) {
    self.longerName = longerName
    self.x = x
  }

  @MainActor
  var value: Int { longerName }
}
let attributed = AttributedComputed(longerName: 1, x: "two")
