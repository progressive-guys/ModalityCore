// MARK: - Группировка после сокращения guard
func requireBoth(_ first: Bool, _ second: Bool) {
  guard first else {
    return
  }

  guard second else {
    return
  }
}

/// Output
func requireBoth(_ first: Bool, _ second: Bool) {
  guard first else { return }
  guard second else { return }
}

// MARK: - Сортировка импортов вместе с исправлением отступов
import Foundation
import Dispatch

func value() -> Int {
    1
}

/// Output
import Dispatch
import Foundation

func value() -> Int {
  1
}
