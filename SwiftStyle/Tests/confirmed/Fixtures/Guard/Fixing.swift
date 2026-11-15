// MARK: - Короткое тело с return помещается на одной строке
func nonnegative(_ value: Int) -> Int? {
  guard value >= 0 else {
    return nil
  }

  return value
}

/// Output
func nonnegative(_ value: Int) -> Int? {
  guard value >= 0 else { return nil }

  return value
}

// MARK: - Перенос условий начинается перед первым условием
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

/// Output
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
