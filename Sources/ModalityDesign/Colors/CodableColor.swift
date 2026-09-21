import SwiftUI

@propertyWrapper
public enum CodableColor: Codable, Equatable {
  case primary
  case white
  case rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)

  public init(wrappedValue: Color) {
    switch wrappedValue {
    case .primary: self = .primary
    case .white: self = .white
    default:
      let components = wrappedValue.components
      self = .rgba(
        red: components.red,
        green: components.green,
        blue: components.blue,
        alpha: components.alpha
      )
    }
  }

  public var wrappedValue: Color {
    get {
      switch self {
      case .primary: .primary
      case .white: .white
      case let .rgba(red, green, blue, alpha):
        Color(.sRGB, red: Double(red), green: Double(green), blue: Double(blue), opacity: Double(alpha))
      }
    }
    set { self = Self(wrappedValue: newValue) }
  }
}
