// MARK: - Перенос перед замыканием в цепочке
enum Examples {
  static func value(_ values: [Int]) -> [Int] {
    values.map { $0 + 1 }.filter { value in
      value > 0
    }
  }
}

/// Output
enum Examples {

  static func value(_ values: [Int]) -> [Int] {
    values.map { $0 + 1 }
      .filter { value in
        value > 0
      }
  }
}

// MARK: - Вызов с замыканием примыкает к многострочному основанию
enum Library {

  static func files(in folder: URL) throws -> [URL] {
    try FileManager.default.contentsOfDirectory(
      at: folder,
      includingPropertiesForKeys: [.isDirectoryKey],
      options: .skipsHiddenFiles
    )
      .flatMap { url in
        url.pathExtension == "xml" ? [url] : []
      }
  }
}

/// Output
enum Library {

  static func files(in folder: URL) throws -> [URL] {
    try FileManager.default.contentsOfDirectory(
      at: folder,
      includingPropertiesForKeys: [.isDirectoryKey],
      options: .skipsHiddenFiles
    ).flatMap { url in
        url.pathExtension == "xml" ? [url] : []
      }
  }
}

// MARK: - Переносы цепочек вызовов и обращений к свойствам (1)
enum Examples {

  static func value(_ values: [Int], _ value: Int) -> Bool {
    values.sorted().contains(
      value
    )
  }

  static func returnedValues() -> [Int] {
    let text = String(
      repeating: "a",
      count: 2
    )

    let count = text.count

    return Array(
      repeating: count,
      count: 2
    )
      .map { value in
        value + 1
      }
  }
}

/// Output
enum Examples {

  static func value(_ values: [Int], _ value: Int) -> Bool {
    values.sorted()
      .contains(
        value
      )
  }

  static func returnedValues() -> [Int] {
    let text = String(
      repeating: "a",
      count: 2
    )

    let count = text.count

    return Array(
      repeating: count,
      count: 2
    ).map { value in
        value + 1
      }
  }
}

// MARK: - Переносы цепочек вызовов и обращений к свойствам (2)
enum Examples {

  static func value(_ values: [Int]) -> Int {
    values.sorted().dropFirst()
      .count
  }

  static func reducedValues() -> [Int] {
    Array(
      repeating: 1,
      count: 2
    )
      .filter {
        true
      }
      .reduce(
        into: []
      ) { values, value in
        values.append(value)
      }
  }
}

/// Output
enum Examples {

  static func value(_ values: [Int]) -> Int {
    values.sorted()
      .dropFirst()
      .count
  }

  static func reducedValues() -> [Int] {
    Array(
      repeating: 1,
      count: 2
    ).filter {
        true
      }.reduce(
        into: []
      ) { values, value in
        values.append(value)
      }
  }
}
