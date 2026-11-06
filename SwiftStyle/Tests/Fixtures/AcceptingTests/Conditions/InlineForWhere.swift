enum Examples {

  static func forWhere(_ values: [Int]) -> Void {
    for value in values where abs(abs(value)) > 0 {
      print(value)
    }
  }
}
