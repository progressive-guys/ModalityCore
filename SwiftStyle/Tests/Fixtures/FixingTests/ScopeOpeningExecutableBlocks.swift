// MARK: - Input
enum Examples {

  static var value: Void {

    get {

      print(
        1,
        2
      )
    }
    set {

      print(
        1,
        2
      )
    }
  }

  static func control(_ value: Int) {

    if value > 0 {

      // Keep the leading comment.
      print(
        1,
        2
      )
    } else {

      print(
        1,
        2
      )
    }

    guard value != 0 else {

      print(
        1,
        2
      )
      return
    }

    for item in [value] {

      print(
        item,
        2
      )
    }

    while value < 0 {

      print(
        1,
        2
      )
    }

    repeat {

      print(
        1,
        2
      )
    } while value < 0

    defer {

      print(
        1,
        2
      )
    }

    do {

      print(
        1,
        2
      )
    } catch {

      print(
        1,
        2
      )
    }

    switch value {

    case 0:
      print(0)
    case 1:
      print(1)
    default:
      print(2)
    }
  }

  static func closures() {

    let first = {

      print(
        1,
        2
      )
    }
    first()

    let second = { (value: Int) in

      print(
        value,
        2
      )
    }
    second(1)
  }
}

final class Owner {

  init() {

    print(
      1,
      2
    )
  }

  deinit {

    print(
      1,
      2
    )
  }
}

// MARK: - Output
enum Examples {

  static var value: Void {
    get {
      print(
        1,
        2
      )
    }
    set {
      print(
        1,
        2
      )
    }
  }

  static func control(_ value: Int) {
    if value > 0 {
      // Keep the leading comment.
      print(
        1,
        2
      )
    } else {
      print(
        1,
        2
      )
    }

    guard value != 0 else {
      print(
        1,
        2
      )

      return
    }

    for item in [value] {
      print(
        item,
        2
      )
    }

    while value < 0 {
      print(
        1,
        2
      )
    }

    repeat {
      print(
        1,
        2
      )
    } while value < 0

    defer {
      print(
        1,
        2
      )
    }

    do {
      print(
        1,
        2
      )
    } catch {
      print(
        1,
        2
      )
    }

    switch value {
    case 0:
      print(0)

    case 1:
      print(1)

    default:
      print(2)
    }
  }

  static func closures() {
    let first = {
      print(
        1,
        2
      )
    }
    first()

    let second = { (value: Int) in
      print(
        value,
        2
      )
    }
    second(1)
  }
}

final class Owner {

  init() {
    print(
      1,
      2
    )
  }

  deinit {
    print(
      1,
      2
    )
  }
}
