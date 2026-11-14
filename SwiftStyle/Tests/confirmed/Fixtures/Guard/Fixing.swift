// MARK: - Case CompactReturnBody
// MARK: Input
func nonnegative(_ value: Int) -> Int? {
  guard value >= 0 else {
    return nil
  }

  return value
}

// MARK: Output
func nonnegative(_ value: Int) -> Int? {
  guard value >= 0 else { return nil }

  return value
}

// MARK: - Case ConditionsBeforeFirst
// MARK: Input
func total(
  firstMeasurementCandidateForCalibration: Int?,
  secondMeasurementCandidateForCalibration: Int?,
  thirdMeasurementCandidateForCalibration: Int?
) -> Int? {
  guard let firstMeasurementCandidateForCalibration,
        let secondMeasurementCandidateForCalibration,
        let thirdMeasurementCandidateForCalibration
  else { return nil }

  return firstMeasurementCandidateForCalibration
    + secondMeasurementCandidateForCalibration
    + thirdMeasurementCandidateForCalibration
}

// MARK: Output
func total(
  firstMeasurementCandidateForCalibration: Int?,
  secondMeasurementCandidateForCalibration: Int?,
  thirdMeasurementCandidateForCalibration: Int?
) -> Int? {
  guard
    let firstMeasurementCandidateForCalibration,
    let secondMeasurementCandidateForCalibration,
    let thirdMeasurementCandidateForCalibration
  else { return nil }

  return firstMeasurementCandidateForCalibration
    + secondMeasurementCandidateForCalibration
    + thirdMeasurementCandidateForCalibration
}
