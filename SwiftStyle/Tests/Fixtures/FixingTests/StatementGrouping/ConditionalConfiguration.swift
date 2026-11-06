// MARK: - Input
enum Examples {

  static func headers(_ extra: [String]) -> [String] {
    var fields = ["default"]

    if !extra.isEmpty {
      fields.append(contentsOf: extra)
    }
    return fields
  }
}

// MARK: - Output
enum Examples {

  static func headers(_ extra: [String]) -> [String] {
    var fields = ["default"]
    if !extra.isEmpty {
      fields.append(contentsOf: extra)
    }
    return fields
  }
}
