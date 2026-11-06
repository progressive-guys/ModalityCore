// MARK: - Input
import SwiftUI

struct ConditionalApp: App {

  #if os(macOS)
  private let desktopValue = 1
  #endif

  init() {}

  var body: some Scene { WindowGroup { Text("Example") } }

  #if os(macOS)
  @ViewBuilder private var desktopContent: some View { Text("Desktop") }
  #else
  private var desktopContent: some View { EmptyView() }
  #endif
  @State private var isImporting = false
}

struct NestedBranches {

  func read() -> Int { displayed }

  // Display values.
  #if os(macOS)
  #if DEBUG
  var displayed: Int { 1 }
  #else
  var displayed: Int { 2 }
  #endif
  #else
  var displayed: Int { 3 }
  #endif
  var stored = 0
}

// MARK: - Output
import SwiftUI

struct ConditionalApp: App {

  #if os(macOS)
  private let desktopValue = 1
  #endif
  @State private var isImporting = false

  init() {}

  var body: some Scene { WindowGroup { Text("Example") } }

  #if os(macOS)
  @ViewBuilder
  private var desktopContent: some View { Text("Desktop") }
  #else
  private var desktopContent: some View { EmptyView() }
  #endif
}

struct NestedBranches {

  var stored = 0

  // Display values.
  #if os(macOS)
  #if DEBUG
  var displayed: Int { 1 }
  #else
  var displayed: Int { 2 }
  #endif
  #else
  var displayed: Int { 3 }
  #endif

  func read() -> Int { displayed }
}
