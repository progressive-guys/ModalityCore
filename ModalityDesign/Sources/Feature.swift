import os
import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// Functional Block: Feature, Module, Screen, User Flow
@MainActor
public protocol Feature: Identifiable {

  // Configuration data passed at creation: ID, initial state, display options
  associatedtype Input

  // Callbacks the module triggers: Navigation actions, data emissions
  associatedtype Output

  // Reactive (Combine Publishers, Observable objects, RxSwift Streams)
  associatedtype State
  associatedtype Body: View

  var id: ObjectIdentifier { get }
  var input: Input { get }
  var output: Output { get }
  var state: State { get }
  var view: Body { get }

  #if canImport(UIKit)
  var vc: UIViewController { get }
  #elseif canImport(AppKit)
  var vc: NSViewController { get }
  #endif
}

extension Feature {
  public var input: Void { () }
  public var state: Void { () }
  public var output: Void { () }
}

extension Feature {

  #if canImport(UIKit)
  public var vc: UIViewController {
    UIHostingController(rootView: view)
  }

  #elseif canImport(AppKit)
  public var vc: NSViewController {
    NSHostingController(rootView: view)
  }
  #endif
}

public extension Feature where ID == ObjectIdentifier {
  nonisolated var id: ObjectIdentifier { ObjectIdentifier(Self.self) }
}

@MainActor
public struct MockFeature: Feature {

  public typealias Input = String

  public typealias Output = Void

  public typealias state = Void

  public let input: Input

  public init(input: Input) {
    self.input = input
  }

  public var view: some View {
    Text(input)
  }
}
