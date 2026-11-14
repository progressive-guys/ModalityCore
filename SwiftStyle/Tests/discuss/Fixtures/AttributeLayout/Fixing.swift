// MARK: - Case AccessorPropertyAttributeStack
// MARK: Input
struct Example {
  @MainActor @available(*, deprecated) var value: Int {
    get { 0 }
    set { _ = newValue }
  }
}

// MARK: Output
struct Example {

  @MainActor
  @available(*, deprecated)
  var value: Int {
    get { 0 }
    set { _ = newValue }
  }
}

// MARK: - Case AvailabilityBeforeInlineObjC
// MARK: Input
import Foundation

final class Example: NSObject {
  @available(*, deprecated) @objc(value:) func value(_ input: Int) -> Int { input }
}

// MARK: Output
import Foundation

final class Example: NSObject {
  @available(*, deprecated)
  @objc(value:) func value(_ input: Int) -> Int { input }
}

// MARK: - Case AvailabilityBeforeInlineWrapper
// MARK: Input
import Combine

final class Example {
  @available(*, deprecated) @Published var value = 0
}

// MARK: Output
import Combine

final class Example {
  @available(*, deprecated)
  @Published
  var value = 0
}

// MARK: - Case AvailabilityBeforeMultipleInlineAttributes
// MARK: Input
import Foundation

final class Example: NSObject {
  @available(*, deprecated) @objc @concurrent func compute(_ input: Int) async -> Int { input }
}

// MARK: Output
import Foundation

final class Example: NSObject {
  @available(*, deprecated)
  @objc @concurrent func compute(_ input: Int) async -> Int { input }
}

// MARK: - Case AvailabilityBetweenComputedProperties
// MARK: Input
class Neighbors {
  var before: Int { 0 }
  @available(*, deprecated, message: "This message makes the complete computed property declaration exceed the line limit.") var value: Int { 0 }
  var after: Int { 0 }
}

// MARK: Output
class Neighbors {

  var before: Int { 0 }

  @available(*, deprecated, message: "This message makes the complete computed property declaration exceed the line limit.")
  var value: Int { 0 }

  var after: Int { 0 }
}

// MARK: - Case CommentsStayWithAttributes
// MARK: Input
struct Example {
  @MainActor /* Actor isolation. */ @available(*, deprecated, message: "Use another property.") // Availability.
  var value: Int { 0 }
}

// MARK: Output
struct Example {
  @MainActor /* Actor isolation. */
  @available(*, deprecated, message: "Use another property.") // Availability.
  var value: Int { 0 }
}

// MARK: - Case ComputedPropertyAttributeStack
// MARK: Input
final class Example {
  @MainActor @available(*, deprecated) var value: Int { 0 }
}

// MARK: Output
final class Example {
  @MainActor
  @available(*, deprecated)
  var value: Int { 0 }
}

// MARK: - Case ComputedPropertyAvailabilityOnSeparateLine
// MARK: Input
final class Example {
  @available(*, deprecated) var value: Int { 0 }
}

// MARK: Output
final class Example {
  @available(*, deprecated)
  var value: Int { 0 }
}

// MARK: - Case ConcurrentAttributeAtInlineLimit
// MARK: Input
final class ConcurrentExample {
  @concurrent
  func calculateValue(_ first: Int, second: Int, third: Int, fourth: Int, fifth: Int) async -> Int { first }
}

// MARK: Output
final class ConcurrentExample {
  @concurrent func calculateValue(_ first: Int, second: Int, third: Int, fourth: Int, fifth: Int) async -> Int { first }
}

// MARK: - Case ConcurrentAttributeOverInlineLimit
// MARK: Input
final class ConcurrentExample {
  @concurrent func calculateValues(_ first: Int, second: Int, third: Int, fourth: Int, fifth: Int) async -> Int { first }
}

// MARK: Output
final class ConcurrentExample {
  @concurrent
  func calculateValues(_ first: Int, second: Int, third: Int, fourth: Int, fifth: Int) async -> Int { first }
}

// MARK: - Case ConditionalComputedPropertyAttributes
// MARK: Input
struct Example {
  #if os(macOS)
  @MainActor @available(*, deprecated)
  #else
  @MainActor @available(*, unavailable)
  #endif
  var value: Int { 0 }
}

// MARK: Output
struct Example {

  #if os(macOS)
  @MainActor
  @available(*, deprecated)
  #else
  @MainActor
  @available(*, unavailable)
  #endif
  var value: Int { 0 }
}

// MARK: - Case ConditionalStoredPropertyAttributes
// MARK: Input
final class Example {
  #if os(macOS)
  @available(*, deprecated) @MainActor
  #endif
  var value = 0
}

// MARK: Output
final class Example {

  #if os(macOS)
  @available(*, deprecated)
  @MainActor
  #endif
  var value = 0
}

// MARK: - Case FunctionAttributePreservesTypeAttributes
// MARK: Input
final class Example {
  @available(*, deprecated) func action(_ body: @escaping @Sendable () -> Void) -> @Sendable () -> Void {
    body
  }
}

// MARK: Output
final class Example {

  @available(*, deprecated)
  func action(_ body: @escaping @Sendable () -> Void) -> @Sendable () -> Void {
    body
  }
}

// MARK: - Case GapBeforeStandalonePropertyAttribute
// MARK: Input
import AppKit

struct Example {
  var appearance: NSAppearance.Name { .aqua }
  @MainActor
  var background: NSColor { .black }
}

// MARK: Output
import AppKit

struct Example {
  var appearance: NSAppearance.Name { .aqua }

  @MainActor
  var background: NSColor { .black }
}

// MARK: - Case GroupStoredAttributeKinds
// MARK: Input
import Combine

class Example {
  @Published private var settingsTitle: String = "Settings"
  @available(*, deprecated) private var isSettingsPresented: Bool = false
  @Published private var count: Int = 0
  @available(*, deprecated) private var active = false
  @Published private var label: String = "Label"
}

// MARK: Output
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

// MARK: - Case ImportAttributeJoinsImport
// MARK: Input
@preconcurrency
import Foundation

// MARK: Output
@preconcurrency import Foundation

// MARK: - Case InitializerAvailabilityOnSeparateLine
// MARK: Input
final class Example {
  @available(*, deprecated) init() {}
}

// MARK: Output
final class Example {
  @available(*, deprecated)
  init() {}
}

// MARK: - Case InlineAttributeLineComment
// MARK: Input
import Foundation

final class Example: NSObject {
  @available(*, deprecated) @objc // Called through Objective-C.
  func value() -> Int { 0 }
}

// MARK: Output
import Foundation

final class Example: NSObject {
  @available(*, deprecated)
  @objc // Called through Objective-C.
  func value() -> Int { 0 }
}

// MARK: - Case LongStoredAvailabilityOnSeparateLine
// MARK: Input
class Width121 {
  @available(*, deprecated, message: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx") var value: Int = 0
}

// MARK: Output
class Width121 {
  @available(*, deprecated, message: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
  var value: Int = 0
}

// MARK: - Case MultilineAttributeArgumentsAndFollowingAttribute
// MARK: Input
struct Example {
  @available(
    *,
    deprecated,
    message: "Use another property."
  ) @MainActor var value: Int { 0 }
}

// MARK: Output
struct Example {

  @available(
    *,
    deprecated,
    message: "Use another property."
  )
  @MainActor
  var value: Int { 0 }
}

// MARK: - Case ObjCAttributeAtInlineLimit
// MARK: Input
import Foundation

final class ObjectiveCExample: NSObject {
  @objc(exportValueForConfiguredProject:defaultValue:)
  func export(_ projectIdentifier: String, defaultValue: String) {}
}

// MARK: Output
import Foundation

final class ObjectiveCExample: NSObject {
  @objc(exportValueForConfiguredProject:defaultValue:) func export(_ projectIdentifier: String, defaultValue: String) {}
}

// MARK: - Case ObjCAttributeOverInlineLimit
// MARK: Input
import Foundation

final class ObjectiveCExample: NSObject {
  @objc(exportValueForConfiguredProjects:defaultValue:) func export(_ projectIdentifier: String, defaultValue: String) {}
}

// MARK: Output
import Foundation

final class ObjectiveCExample: NSObject {
  @objc(exportValueForConfiguredProjects:defaultValue:)
  func export(_ projectIdentifier: String, defaultValue: String) {}
}

// MARK: - Case PreserveAttributeOrder
// MARK: Input
import Foundation

final class Example: NSObject {
  @objc @available(*, deprecated) func value() -> Int { 0 }
}

// MARK: Output
import Foundation

final class Example: NSObject {
  @objc
  @available(*, deprecated)
  func value() -> Int { 0 }
}

// MARK: - Case ProtocolActorAtInlineLimit
// MARK: Input
protocol FitsLimit {
  @MainActor
  func loadTune(_ identifier: String, includeMuted: Bool, useCache: Bool, includeArchived: Bool) async -> Int
}

// MARK: Output
protocol FitsLimit {
  @MainActor func loadTune(_ identifier: String, includeMuted: Bool, useCache: Bool, includeArchived: Bool) async -> Int
}

// MARK: - Case ProtocolActorOverInlineLimit
// MARK: Input
protocol ExceedsLimit {
  @MainActor func loadTrack(_ identifier: String, includeMuted: Bool, useCache: Bool, includeArchived: Bool) async -> Int
}

// MARK: Output
protocol ExceedsLimit {
  @MainActor
  func loadTrack(_ identifier: String, includeMuted: Bool, useCache: Bool, includeArchived: Bool) async -> Int
}

// MARK: - Case ProtocolDeclarationAttributeStack
// MARK: Input
@MainActor @available(*, deprecated) protocol Example {
  @available(*, deprecated)
  func value() -> Int
}

// MARK: Output
@MainActor
@available(*, deprecated)
protocol Example {
  @available(*, deprecated)
  func value() -> Int
}

// MARK: - Case ProtocolExtensionImplementationAttribute
// MARK: Input
protocol Example {
  func value() -> Int
}

extension Example {
  @available(*, deprecated) func value() -> Int { 0 }
}

// MARK: Output
protocol Example {
  func value() -> Int
}

extension Example {
  @available(*, deprecated)
  func value() -> Int { 0 }
}

// MARK: - Case StoredAvailabilityMultilineArguments
// MARK: Input
final class Example {
  @available(
    *,
    deprecated,
    message: "Use another property."
  ) var value = 0
}

// MARK: Output
final class Example {

  @available(
    *,
    deprecated,
    message: "Use another property."
  )
  var value = 0
}

// MARK: - Case TypeDeclarationAttributeStack
// MARK: Input
@MainActor @available(*, deprecated) final class Example {
}

// MARK: Output
@MainActor
@available(*, deprecated)
final class Example {
}

// MARK: - Case ViewBuilderComputedPropertyStack
// MARK: Input
import SwiftUI

struct Example {
  @MainActor @ViewBuilder var rootView: some View {
    Text("Example")
  }
}

// MARK: Output
import SwiftUI

struct Example {

  @MainActor
  @ViewBuilder
  var rootView: some View {
    Text("Example")
  }
}
