enum Examples {

  static func update(_ isEmpty: inout Bool, values: [[Int]]) {
    isEmpty = true

    guard values.allSatisfy(\.isEmpty) else { return }

    print("started")
    print("ready")
  }
}
