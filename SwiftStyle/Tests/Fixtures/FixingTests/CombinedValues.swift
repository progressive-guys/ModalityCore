// MARK: - Input
var calls: [String] = []
let first: @MainActor () -> Int? = {
  calls.append("first")
  return 7
}
let second: @MainActor (Int) -> Bool = { value in
  calls.append("second")
  return value == 7
}
if let value = first() {
  // Keep this condition after the binding.
  if second(value) {
    calls.append("body")
  } // Keep this closing comment.
}
calls = []
let missing: @MainActor () -> Int? = {
  calls.append("missing")
  return nil
}
if let value = missing() {
  if second(value) {
    calls.append("body")
  }
}
let text = "world"
let greeting = """
  Hello "\(text)"
  """
let escaped = #"a\b"# + "\n\"quoted\""
let longText = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz" + "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"

// MARK: - Output
var calls: [String] = []
let first: @MainActor () -> Int? = {
  calls.append("first")
  return 7
}
let second: @MainActor (Int) -> Bool = { value in
  calls.append("second")
  return value == 7
}
if let value = first() ,
  // Keep this condition after the binding.
   second(value)
{
    calls.append("body")
  } // Keep this closing comment.

calls = []
let missing: @MainActor () -> Int? = {
  calls.append("missing")
  return nil
}
if let value = missing() ,
   second(value)
{
    calls.append("body")
  }

let text = "world"
let greeting = "Hello \"\(text)\""
let escaped = "a\\b\n\"quoted\""
let longText = """
  abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLM\
  NOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ
  """
