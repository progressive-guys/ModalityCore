// MARK: - Input
final class Example {
  @available(
    *,
    deprecated,
    message: "Use another property."
  ) var value = 0
}

// MARK: - Output
final class Example {

  @available(
    *,
    deprecated,
    message: "Use another property."
  )
  var value = 0
}
