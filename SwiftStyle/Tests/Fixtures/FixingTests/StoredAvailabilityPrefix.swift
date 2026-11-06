// MARK: - Input
import Combine

final class Example {
  @available(*, deprecated) @Published var value = 0
}

// MARK: - Output
import Combine

final class Example {
  @available(*, deprecated)
  @Published var value = 0
}
