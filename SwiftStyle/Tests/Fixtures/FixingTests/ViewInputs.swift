// MARK: - Input
import SwiftUI

struct Example: View {
  let title: String
  @Binding var selected: Bool
  @Environment(\.colorScheme) private var colorScheme
  @State private var cached: Int?
  let action: () -> Int
  var count: Int = 2

  var body: some View { Text(title) }

  func describe() -> String { "\(title) \(selected) \(action()) \(count) \(cached ?? 0)" }
}

let example = Example(title: "hello", selected: .constant(true), action: { 3 })

// MARK: - Output
import SwiftUI

struct Example: View {

  private let title: String
  private let action: () -> Int

  private var count: Int 
  @Binding private var selected: Bool
  @Environment(\.colorScheme) private var colorScheme
  @State private var cached: Int?

  init(title: String, selected: Binding<Bool>, action: @escaping () -> Int, count: Int = 2) {
    self.title = title
    self._selected = selected
    self.action = action
    self.count = count
  }

  var body: some View { Text(title) }

  func describe() -> String { "\(title) \(selected) \(action()) \(count) \(cached ?? 0)" }
}

let example = Example(title: "hello", selected: .constant(true), action: { 3 })
