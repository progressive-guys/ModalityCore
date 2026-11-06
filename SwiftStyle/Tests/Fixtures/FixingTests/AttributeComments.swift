// MARK: - Input
struct Example {
  @MainActor /* Actor isolation. */ @available(*, deprecated, message: "Use another property.") // Availability.
  var value: Int { 0 }
}

// MARK: - Output
struct Example {
  @MainActor /* Actor isolation. */
  @available(*, deprecated, message: "Use another property.") // Availability.
  var value: Int { 0 }
}
