// MARK: - Переносы аннотаций свойств с аксессорами, аргументами и ViewBuilder
struct Example {

  @MainActor @available(*, deprecated) var value: Int {
    get { 0 }
    set { _ = newValue }
  }

  @available(
    *,
    deprecated,
    message: "Use another property."
  ) @MainActor var other: Int { 0 }

  @MainActor @ViewBuilder var rootView: some View {
    Text("Example")
  }
}

/// Output
struct Example {

  @MainActor
  @available(*, deprecated)
  var value: Int {
    get { 0 }
    set { _ = newValue }
  }

  @available(
    *,
    deprecated,
    message: "Use another property."
  )
  @MainActor
  var other: Int {
    0
  }

  @MainActor
  @ViewBuilder
  var rootView: some View {
    Text("Example")
  }
}

// MARK: - Порядок и переносы аннотаций методов Objective-C
final class Example: NSObject {

  @available(*, deprecated) @objc(value:) func value(_ input: Int) -> Int { input }

  @available(*, deprecated) @objc @concurrent func compute(_ input: Int) async -> Int { input }

  @available(*, deprecated) @objc // Called through Objective-C.
  func value() -> Int { 0 }

  @objc @available(*, deprecated) func orderedValue() -> Int { 0 }
}

/// Output
final class Example: NSObject {

  @available(*, deprecated)
  @objc(value:)
  func value(_ input: Int) -> Int {
    input
  }

  @available(*, deprecated)
  @objc
  @concurrent func compute(_ input: Int) async -> Int {
    input
  }

  @available(*, deprecated)
  @objc // Called through Objective-C.
  func value() -> Int {
    0
  }

  @objc
  @available(*, deprecated)
  func orderedValue() -> Int {
    0
  }
}

// MARK: - Available и Published перед свойством переносятся на отдельные строки
final class Example {
  @available(*, deprecated) @Published var value = 0
}

/// Output
final class Example {

  @available(*, deprecated)
  @Published
  var value = 0
}

// MARK: - Длинная аннотация available переносится над вычисляемым свойством
class Neighbors {
  var before: Int { 0 }
  @available(*, deprecated, message: "This message makes the complete computed property declaration exceed the line limit.") var value: Int { 0 }
  var after: Int { 0 }
}

/// Output
class Neighbors {

  var before: Int {
    0
  }

  @available(*, deprecated, message: "This message makes the complete computed property declaration exceed the line limit.")
  var value: Int {
    0
  }

  var after: Int {
    0
  }
}

// MARK: - Комментарии остаются рядом со своими аннотациями
struct Example {
  @MainActor /* Actor isolation. */ @available(*, deprecated, message: "Use another property.") // Availability.
  var value: Int { 0 }
}

/// Output
struct Example {

  @MainActor /* Actor isolation. */
  @available(*, deprecated, message: "Use another property.") // Availability.
  var value: Int {
    0
  }
}

// MARK: - Аннотации вычисляемых свойств переносятся на отдельные строки
final class Example {

  @MainActor @available(*, deprecated) var value: Int { 0 }

  @available(*, deprecated) var availableValue: Int { 0 }
}

/// Output
final class Example {

  @MainActor
  @available(*, deprecated)
  var value: Int {
    0
  }

  @available(*, deprecated)
  var availableValue: Int {
    0
  }
}

// MARK: - Аннотация concurrent у однострочной и многострочной функций
final class ConcurrentExample {

  @concurrent
  func calculateValue(_ first: Int, second: Int, third: Int, fourth: Int, fifth: Int) async -> Int { first }

  @concurrent func calculateValues(_ first: Int, second: Int, third: Int, fourth: Int, fifth: Int) async -> Int {
    first
  }
}

/// Output
final class ConcurrentExample {

  @concurrent func calculateValue(_ first: Int, second: Int, third: Int, fourth: Int, fifth: Int) async -> Int {
    first
  }

  @concurrent
  func calculateValues(_ first: Int, second: Int, third: Int, fourth: Int, fifth: Int) async -> LongType {
    first
  }
}

// MARK: - Аннотации вычисляемого свойства разделяются внутри веток условной компиляции
struct Example {
  #if os(macOS)
  @MainActor @available(*, deprecated)
  #else
  @MainActor @available(*, unavailable)
  #endif
  var value: Int { 0 }
}

/// Output
struct Example {

  #if os(macOS)
  @MainActor
  @available(*, deprecated)
  #else
  @MainActor
  @available(*, unavailable)
  #endif
 
  var value: Int {
    0
  }
}

// MARK: - Аннотации условного свойства и функции с аннотациями типов
final class Example {

  #if os(macOS)
  @available(*, deprecated) @MainActor
  #endif
  var value = 0

  @available(*, deprecated) func action(_ body: @escaping @Sendable () -> Void) -> @Sendable () -> Void {
    body
  }
}

/// Output
final class Example {

  #if os(macOS)
  @available(*, deprecated)
  @MainActor
  #endif

  var value = 0

  @available(*, deprecated)
  func action(_ body: @escaping @Sendable () -> Void) -> @Sendable () -> Void {
    body
  }
}

// MARK: - Пустая строка перед отдельной аннотацией свойства
struct Example {
  var appearance: NSAppearance.Name { .aqua }
  @MainActor
  var background: NSColor { .black }
}

/// Output
struct Example {

  var appearance: NSAppearance.Name {
    .aqua
  }

  @MainActor
  var background: NSColor {
    .black
  }
}

// MARK: - Группировка хранимых свойств по видам аннотаций
class Example {
  @Published private var settingsTitle: String = "Settings"
  @available(*, deprecated) private var isSettingsPresented: Bool = false
  @Published private var count: Int = 0
  @available(*, deprecated) private var active = false
  @Published private var label: String = "Label"
}

/// Output
class Example {

  @Published private var count: Int = 0
  @Published private var label: String = "Label"
  @Published private var settingsTitle: String = "Settings"

  @available(*, deprecated)
  private var active = false

  @available(*, deprecated)
  private var isSettingsPresented: Bool = false
}

// MARK: - Аннотация помещается на строке импорта
@preconcurrency
import Foundation

/// Output
@preconcurrency import Foundation

// MARK: - Аннотация available над инициализатором
final class Example {
  @available(*, deprecated) init() {}
}

/// Output
final class Example {

  @available(*, deprecated)
  init() {}
}

// MARK: - Аннотации objc у методов с длинными селекторами
final class ObjectiveCExample: NSObject {

  @objc(exportValueForConfiguredProject:defaultValue:)
  func export(_ projectIdentifier: String, defaultValue: String) {}

  @objc(exportValueForConfiguredProjects:defaultValue:) func exportMany(_ projectIdentifier: String, defaultValue: String) {}
}

/// Output
final class ObjectiveCExample: NSObject {

  @objc(exportValueForConfiguredProject:defaultValue:)
  func export(_ projectIdentifier: String, defaultValue: String) {}

  @objc(exportValueForConfiguredProjects:defaultValue:)
  func exportMany(_ projectIdentifier: String, defaultValue: String) {}
}

// MARK: - Аннотация требования протокола при допустимой и превышенной длине строки
protocol Example {

  @MainActor
  func loadTune(_ identifier: String, includeMuted: Bool, useCache: Bool, includeArchived: Bool) async -> Int

  @MainActor func loadTrack(_ identifier: String, includeMuted: Bool, useCache: Bool, includeArchived: Bool) async -> Int
}

/// Output
protocol Example {

  @MainActor func loadTune(_ identifier: String, includeMuted: Bool, useCache: Bool, includeArchived: Bool) async -> Int

  @MainActor
  func loadTrack(_ identifier: String, includeMuted: Bool, useCache: Bool, includeArchived: Bool) async -> Int
}

// MARK: - Аннотации протокола переносятся на отдельные строки
@MainActor @available(*, deprecated) protocol Example {
  @available(*, deprecated)
  func value() -> Int
}

/// Output
@MainActor
@available(*, deprecated)
protocol Example {

  @available(*, deprecated)
  func value() -> Int
}

// MARK: - Аннотация available переносится над реализацией метода в расширении
protocol Example {
  func value() -> Int
}

extension Example {
  @available(*, deprecated) func value() -> Int { 0 }
}

/// Output
protocol Example {
  func value() -> Int
}

extension Example {

  @available(*, deprecated)
  func value() -> Int {
    0
  }
}

// MARK: - После многострочной available объявление свойства переносится
final class Example {
  @available(
    *,
    deprecated,
    message: "Use another property."
  ) var value = 0
}

/// Output
final class Example {

  @available(
    *,
    deprecated,
    message: "Use another property."
  )
  var value = 0
}

// MARK: - Аннотации класса переносятся на отдельные строки
@MainActor @available(*, deprecated) final class Example {
}

/// Output
@MainActor
@available(*, deprecated)
final class Example {
}
