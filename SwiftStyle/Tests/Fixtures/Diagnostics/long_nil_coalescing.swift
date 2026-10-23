// MARK: - Accepted

enum Accepted {
  static func value(_ extremelyLongSourceValueWithAdditionalContextAndDetails: Int?,
    _ extremelyLongFallbackValueWithAdditionalContextAndDetails: Int) -> Int {
    let result = extremelyLongSourceValueWithAdditionalContextAndDetails
      ?? extremelyLongFallbackValueWithAdditionalContextAndDetails
    return result
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ extremelyLongSourceValueWithAdditionalContextAndDetails: Int?,
    _ extremelyLongFallbackValueWithAdditionalContextAndDetails: Int) -> Int {
    let result = extremelyLongSourceValueWithAdditionalContextAndDetails ?? extremelyLongFallbackValueWithAdditionalContextAndDetails
    return result
  }
}
