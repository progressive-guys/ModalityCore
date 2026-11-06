import SwiftUI

enum Examples {

  struct Content: View {

    static var shared = 1

    private let title: String

    @Binding private var selected: Bool
    @Environment(\.colorScheme) private var colorScheme

    init(title: String, selected: Binding<Bool>) {
      self.title = title
      self._selected = selected
    }

    private var subtitle: String { title }
    var body: some View { Text(title) }
  }
}
