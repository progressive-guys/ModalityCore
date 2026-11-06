// MARK: - Input
enum Examples {

  static func process(_ values: inout [Int]) {
    values.reserveCapacity(4)


    values.append(1)
    values.append(2)
    values.append(3)
  }
}

// MARK: - Output
enum Examples {

  static func process(_ values: inout [Int]) {
    values.reserveCapacity(4)

    values.append(1)
    values.append(2)
    values.append(3)
  }
}
