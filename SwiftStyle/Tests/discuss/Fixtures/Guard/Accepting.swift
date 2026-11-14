// MARK: - Case CommentPreventsCompaction
func nonnegative(_ value: Int) -> Int? {
  guard value >= 0 else {
    // A negative value is unavailable.
    return nil
  }

  return value
}
