infix operator ~~== : ComparisonPrecedence
infix operator ~~!= : ComparisonPrecedence
infix operator ~~<  : ComparisonPrecedence
infix operator ~~>  : ComparisonPrecedence
infix operator ~~<= : ComparisonPrecedence
infix operator ~~>= : ComparisonPrecedence

extension BinaryFloatingPoint {

  @inlinable
  static func tolerance(_ a: Self, _ b: Self, ulps: Self = 16) -> Self {
    // relative tolerance: ulps * ULP at the larger magnitude
    let rel = ulps * max(a.magnitude, b.magnitude) * Self.ulpOfOne
    // absolute floor: ulps * ULP at 1.0 (works well near zero)
    let absFloor = ulps * Self.ulpOfOne
    return max(rel, absFloor)
  }

  public static func ~~==(_ a: Self, _ b: Self) -> Bool {
    abs(a - b) <= tolerance(a, b)
  }

  public static func ~~!=(_ a: Self, _ b: Self) -> Bool {
    !(a ~~== b)
  }

  public static func ~~<(_ a: Self, _ b: Self) -> Bool {
    // strictly less only if below by more than tolerance
    (b - a) > tolerance(a, b)
  }

  public static func ~~>(_ a: Self, _ b: Self) -> Bool {
    // strictly greater only if above by more than tolerance
    (a - b) > tolerance(a, b)
  }

  public static func ~~<=(_ a: Self, _ b: Self) -> Bool {
    (a ~~< b) || (a ~~== b)
  }

  public static func ~~>=(_ a: Self, _ b: Self) -> Bool {
    (a ~~> b) || (a ~~== b)
  }
}
