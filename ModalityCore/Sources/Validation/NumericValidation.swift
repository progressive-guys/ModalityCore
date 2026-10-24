import Foundation

public enum NumericValidationError: Error, Equatable, Sendable {
  case nonFinite(String)
  case nonPositive(String)
  case negative(String)
  case missingField(String)
}

public extension NumericValidationError {
  var message: String {
    switch self {
    case .nonFinite(let name): "\(name) must be finite."
    case .nonPositive(let name): "\(name) must be positive."
    case .negative(let name): "\(name) must be non-negative."
    case .missingField(let name): "Numeric field \(name) is missing."
    }
  }
}

extension NumericValidationError: LocalizedError {
  public var errorDescription: String? { message }
}

public enum NumericValidation {
  public enum Constraint: Sendable {
    case finite, positive, nonNegative
  }

  public static func validate<Value: BinaryFloatingPoint>(
    _ value: Value,
    named name: String,
    constraint: Constraint
  ) throws {
    guard value.isFinite else { throw NumericValidationError.nonFinite(name) }

    switch constraint {
    case .finite: break

    case .positive:
      guard value > 0 else { throw NumericValidationError.nonPositive(name) }

    case .nonNegative:
      guard value >= 0 else { throw NumericValidationError.negative(name) }
    }
  }

  public static func validate<Root>(_ value: Root, fields: [String: Constraint]) throws {
    let children = Array(Mirror(reflecting: value).children)
    for field in fields.keys.sorted() {
      let words = field
        .replacingOccurrences( of: "([a-z0-9])([A-Z])", with: "$1 $2", options: .regularExpression )
        .lowercased()
      let name = words.prefix(1).uppercased() + words.dropFirst()
      guard
        let constraint = fields[field],
        let number = children.first(where: { $0.label == field })?.value as? Double
      else { throw NumericValidationError.missingField(name) }

      try validate(number, named: name, constraint: constraint)
    }
  }
}
