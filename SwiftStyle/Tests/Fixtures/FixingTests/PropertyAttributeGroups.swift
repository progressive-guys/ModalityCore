// MARK: - Input
import Combine

class Example {
  @Published private var settingsTitle: String = "Settings"
  @available(*, deprecated) private var isSettingsPresented: Bool = false
  @Published private var count: Int = 0
  @available(*, deprecated) private var active = false
  @Published private var label: String = "Label"
}

// MARK: - Output
import Combine

class Example {

  @Published private var count: Int = 0
  @Published private var label: String = "Label"
  @Published private var settingsTitle: String = "Settings"

  @available(*, deprecated)
  private var active = false

  @available(*, deprecated)
  private var isSettingsPresented: Bool = false
}
