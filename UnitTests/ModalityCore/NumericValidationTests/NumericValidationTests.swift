import ModalityCore
import Testing

struct NumericValidationTests {
  @Test(arguments: [Double.nan, .infinity, -.infinity])
  func rejectsNonFiniteValues(_ value: Double) {
    #expect(throws: NumericValidationError.nonFinite("Width")) {
      try NumericValidation.validate(value, named: "Width", constraint: .positive)
    }
  }

  @Test func distinguishesPositiveAndNonNegative() throws {
    try NumericValidation.validate(0.0, named: "Content inset", constraint: .nonNegative)
    #expect(throws: NumericValidationError.nonPositive("Width")) {
      try NumericValidation.validate(0.0, named: "Width", constraint: .positive)
    }
    #expect(throws: NumericValidationError.negative("Content inset")) {
      try NumericValidation.validate(-1.0, named: "Content inset", constraint: .nonNegative)
    }
  }

  @Test func reflectionUsesReadableFieldNamesAndRejectsTypos() {
    struct Configuration { let contentInset = -1.0 }
    #expect(throws: NumericValidationError.negative("Content inset")) {
      try NumericValidation.validate(Configuration(), fields: ["contentInset": .nonNegative])
    }
    #expect(throws: NumericValidationError.missingField("Missing")) {
      try NumericValidation.validate(Configuration(), fields: ["missing": .finite])
    }
  }
}
