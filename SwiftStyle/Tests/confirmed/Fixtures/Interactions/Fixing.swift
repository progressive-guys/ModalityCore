// MARK: - Case GuardCompactionThenGrouping
// MARK: Input
func requireBoth(_ first: Bool, _ second: Bool) {
  guard first else {
    return
  }

  guard second else {
    return
  }
}

// MARK: Output
func requireBoth(_ first: Bool, _ second: Bool) {
  guard first else { return }
  guard second else { return }
}

// MARK: - Case ImportAndIndentation
// MARK: Input
import Foundation
import Dispatch

func value() -> Int {
    1
}

// MARK: Output
import Dispatch
import Foundation

func value() -> Int {
  1
}
