// MARK: - Input
import Combine

final class Example {
  @Published
  private var first = 0
  @Published private var second = 0
  @MainActor @available(*, deprecated) var value: Int { first + second }
}

// MARK: - Output
import Combine

final class Example {

  @Published private var first = 0
  @Published private var second = 0

  @MainActor
  @available(*, deprecated)
  var value: Int { first + second }
}
