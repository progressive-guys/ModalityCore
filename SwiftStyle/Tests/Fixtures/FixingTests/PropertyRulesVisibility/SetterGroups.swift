// MARK: - Input
import Combine

final class Model {

  @Published private(set) var value = 0
  @Published var isReady = false
}

// MARK: - Output
import Combine

final class Model {
  @Published var isReady = false

  @Published private(set) var value = 0
}
