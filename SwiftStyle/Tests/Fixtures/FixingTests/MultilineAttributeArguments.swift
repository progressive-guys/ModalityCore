// MARK: - Input
struct Example {
  @available(
    *,
    deprecated,
    message: "Use another property."
  ) @MainActor var value: Int { 0 }
}

// MARK: - Output
struct Example {

  @available(
    *,
    deprecated,
    message: "Use another property."
  )
  @MainActor
  var value: Int { 0 }
}
