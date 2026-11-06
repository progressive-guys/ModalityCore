// MARK: - Input
import Foundation

enum Examples {

  static func process(_ input: Int) {
    let error = input

    do {
      throw NSError(domain: "test", code: 0)
    } catch let failure {
      print(error, failure)
    }
  }
}

// MARK: - Output
import Foundation

enum Examples {

  static func process(_ input: Int) {
    let error = input
    do {
      throw NSError(domain: "test", code: 0)
    } catch let failure {
      print(error, failure)
    }
  }
}
