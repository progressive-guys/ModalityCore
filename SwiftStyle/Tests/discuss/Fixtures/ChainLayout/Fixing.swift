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

// MARK: - Цепочка вызовов разделяется перед вызовом с многострочными аргументами
enum Examples {
  static func value(_ values: [Int], _ value: Int) -> Bool {
    values.sorted().contains(
      value
    )
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
}

// MARK: - Вызов после return соединяется с замыканием
enum Examples {
  static func values() -> [Int] {
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

  static func values() -> [Int] {
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

// MARK: - Частично перенесённая цепочка обращений к членам типа
enum Examples {
  static func value(_ values: [Int]) -> Int {
    values.sorted().dropFirst()
      .count
  }
}

/// Output
enum Examples {

  static func value(_ values: [Int]) -> Int {
    values.sorted()
      .dropFirst()
      .count
  }
}

// MARK: - Аргументы продолжения примыкают к многострочному основанию
enum Examples {

  static func values() -> [Int] {
    Array(
      repeating: 1,
      count: 2
    )
      .reduce(
        into: []
      ) { values, value in
        values.append(value)
      }
  }
}

/// Output
enum Examples {

  static func values() -> [Int] {
    Array(
      repeating: 1,
      count: 2
    ).reduce(
        into: []
      ) { values, value in
        values.append(value)
      }
  }
}
