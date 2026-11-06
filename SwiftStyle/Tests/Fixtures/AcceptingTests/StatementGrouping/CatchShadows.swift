import Foundation

enum Examples {

  static func process(_ input: Int) {
    let error = input

    do {
      throw NSError(domain: "test", code: 0)
    } catch {
      print(error)
    }

    print(error)
  }
}
