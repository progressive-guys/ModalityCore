// MARK: - Input
import Combine

class Snapshot {
  @Published
  private(set) var snapshot: Int = 0
}

class MultipleAttributes {
  @MainActor
  @available(*, deprecated)
  var value: Int { 0 }
}

class Width119 {
  @available(*, deprecated, message: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
  var value: Int = 0
}

class Width120 {
  @available(*, deprecated, message: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
  var value: Int = 0
}

class Width121 {
  @available(*, deprecated, message: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx") var value: Int = 0
}

class Neighbors {
  var before: Int { 0 }
  @available(*, deprecated, message: "This message makes the complete computed property declaration exceed the line limit.") var value: Int { 0 }
  var after: Int { 0 }
}

class ShortProperties {
  @available(*, deprecated)
  var a: Int = 0

  @available(*, deprecated)
  var b: Int = 0
}

class Comments {
  @available(*, deprecated)
  // Keep this comment with the property.
  var value: Int = 0
}

class Arguments {
  @available(
    *,
    deprecated,
    message: "Keep the argument layout."
  )
  var value: Int = 0
}

// MARK: - Output
import Combine

class Snapshot {
  @Published private(set) var snapshot: Int = 0
}

class MultipleAttributes {
  @MainActor
  @available(*, deprecated)
  var value: Int { 0 }
}

class Width119 {
  @available(*, deprecated, message: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
  var value: Int = 0
}

class Width120 {
  @available(*, deprecated, message: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
  var value: Int = 0
}

class Width121 {
  @available(*, deprecated, message: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
  var value: Int = 0
}

class Neighbors {

  var before: Int { 0 }

  @available(*, deprecated, message: "This message makes the complete computed property declaration exceed the line limit.")
  var value: Int { 0 }

  var after: Int { 0 }
}

class ShortProperties {

  @available(*, deprecated)
  var a: Int = 0

  @available(*, deprecated)
  var b: Int = 0
}

class Comments {
  @available(*, deprecated)
  // Keep this comment with the property.
  var value: Int = 0
}

class Arguments {

  @available(
    *,
    deprecated,
    message: "Keep the argument layout."
  )
  var value: Int = 0
}
