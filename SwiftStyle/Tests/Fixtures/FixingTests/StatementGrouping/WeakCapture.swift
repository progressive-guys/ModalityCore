// MARK: - Input
import Foundation

enum Examples {

  static func process(_ input: NSObject) {
    let object = input

    let completion = { [weak object] in
      guard let object else { return }
      print(object)
    }
    completion()
  }
}

// MARK: - Output
import Foundation

enum Examples {

  static func process(_ input: NSObject) {
    let object = input
    let completion = { [weak object] in
      guard let object else { return }
      print(object)
    }
    completion()
  }
}
