// MARK: - Case RemoveGapBetweenCompactGuards
// MARK: Input
func requireBoth(_ first: Bool, _ second: Bool) {
  guard first else { return }

  guard second else { return }
}

// MARK: Output
func requireBoth(_ first: Bool, _ second: Bool) {
  guard first else { return }
  guard second else { return }
}
