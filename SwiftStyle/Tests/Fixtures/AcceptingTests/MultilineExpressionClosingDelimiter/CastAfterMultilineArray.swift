enum Examples {

  static func castCollection(_ first: Int) -> [Int] {
    ([
      first
    ] as [Int]).map { $0 }
  }
}
