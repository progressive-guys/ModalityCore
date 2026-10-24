// MARK: - Accepted

enum Accepted {
  struct Note {
    let semitonesNormalized: Int
  }

  struct Pitch {
    let note: Note
  }

  static func notesDistance(_ pitch: Pitch, _ relativePitch: Pitch, _ octaveSubdivisions: Int) -> Double {
    let notesDistance = Double(pitch.note.semitonesNormalized - relativePitch.note.semitonesNormalized)
      / Double(octaveSubdivisions)
    return notesDistance
  }

  static func product(_ leadingContentInset: Double, _ availableContentWidth: Double, _ horizontalScale: Double, _ trailingContentInset: Double) -> Double {
    let resultWithAnExplicitNameForTheComputedWidth = leadingContentInset
      + availableContentWidth * horizontalScale
      - trailingContentInset
    return resultWithAnExplicitNameForTheComputedWidth
  }

  static func longProduct(_ firstMeasuredWidthInPoints: Double, _ secondMeasuredWidthInPoints: Double) -> Double {
    let resultWithAnExplicitNameForTheComputedWidth = firstMeasuredWidthInPoints
      * secondMeasuredWidthInPoints
      / firstMeasuredWidthInPoints
    return resultWithAnExplicitNameForTheComputedWidth
  }

  static func grouped(_ firstMeasuredWidthInPoints: Double, _ secondMeasuredWidthInPoints: Double) -> Double {
    let resultWithAnExplicitNameForTheComputedWidth = (firstMeasuredWidthInPoints - secondMeasuredWidthInPoints)
      / firstMeasuredWidthInPoints
    return resultWithAnExplicitNameForTheComputedWidth
  }

  static func longAdditiveSegment(_ firstMeasuredWidthInPoints: Double, _ secondMeasuredWidthInPoints: Double) -> Double {
    let combinedWidth = firstMeasuredWidthInPoints
      + abs(firstMeasuredWidthInPoints)
      * abs(secondMeasuredWidthInPoints)
      * abs(firstMeasuredWidthInPoints)
      * abs(secondMeasuredWidthInPoints)
    return combinedWidth
  }

  static func longCall(_ firstMeasuredWidthInPoints: Double, _ secondMeasuredWidthInPoints: Double) -> Double {
    let combinedWidth = Double(abs(firstMeasuredWidthInPoints) +
      abs(secondMeasuredWidthInPoints) +
      abs(firstMeasuredWidthInPoints) +
      abs(secondMeasuredWidthInPoints)) / firstMeasuredWidthInPoints
    return combinedWidth
  }

  static func short(_ first: Double, _ second: Double) -> Double {
    first + second * 2
  }

  static func commented(_ first: Double, _ second: Double) -> Double {
    first * // Keep the documented boundary.
      second
  }

  static func multipleArguments(_ first: Double, _ second: Double) -> Double {
    max(
      first,
      second
    ) / 2
  }

  static func unary(_ firstMeasuredWidthInPoints: Double, _ secondMeasuredWidthInPoints: Double) -> Double {
    let resultWithAnExplicitNameForTheComputedWidth = -(firstMeasuredWidthInPoints - secondMeasuredWidthInPoints)
      / firstMeasuredWidthInPoints
    return resultWithAnExplicitNameForTheComputedWidth
  }

  static func shortConversion(_ first: Int, _ second: Int) -> Double {
    Double(first - second) / 12
  }
}

// MARK: - Rejected

enum Rejected {
  static func notesDistance(_ pitch: Accepted.Pitch, _ relativePitch: Accepted.Pitch, _ octaveSubdivisions: Int) -> Double {
    let notesDistance = Double(pitch.note.semitonesNormalized -
      relativePitch.note.semitonesNormalized) / Double(octaveSubdivisions)
    return notesDistance
  }

  static func shortExpression(_ first: Double, _ second: Double) -> Double {
    first
      + second
  }

  static func splitProduct(_ leadingContentInset: Double, _ availableContentWidth: Double, _ horizontalScale: Double, _ trailingContentInset: Double) -> Double {
    let resultWithAnExplicitNameForTheComputedWidth = leadingContentInset + availableContentWidth
      * horizontalScale - trailingContentInset
    return resultWithAnExplicitNameForTheComputedWidth
  }

  static func wrongIndent(_ firstMeasuredWidthInPoints: Double, _ secondMeasuredWidthInPoints: Double) -> Double {
    let resultWithAnExplicitNameForTheComputedWidth = (firstMeasuredWidthInPoints -
        secondMeasuredWidthInPoints) / firstMeasuredWidthInPoints
    return resultWithAnExplicitNameForTheComputedWidth
  }

  static func laterAdditiveTerm(_ firstMeasuredWidthInPoints: Double, _ secondMeasuredWidthInPoints: Double) -> Double {
    let resultWithAnExplicitNameForTheComputedWidth = firstMeasuredWidthInPoints
      / secondMeasuredWidthInPoints + firstMeasuredWidthInPoints
    return resultWithAnExplicitNameForTheComputedWidth
  }

  static func splitRemainder(_ firstMeasuredWidthInPoints: Int, _ secondMeasuredWidthInPoints: Int) -> Int {
    let resultWithAnExplicitNameForTheComputedWidth = firstMeasuredWidthInPoints
      % secondMeasuredWidthInPoints + firstMeasuredWidthInPoints
    return resultWithAnExplicitNameForTheComputedWidth
  }

  static func shortConversion(_ first: Int, _ second: Int) -> Double {
    Double(first -
      second) / 12
  }
}
