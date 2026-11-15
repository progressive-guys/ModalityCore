func requireBoth(_ first: Bool, _ second: Bool) {
  guard first else {
    return
  }

  guard second else {
    return
  }
}

/// Output
func requireBoth(_ first: Bool, _ second: Bool) {
  guard first else { return }
  guard second else { return }
}
