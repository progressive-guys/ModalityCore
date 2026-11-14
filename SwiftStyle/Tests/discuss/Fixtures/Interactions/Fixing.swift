// MARK: - Case AttributeThenIndent
// MARK: Input
struct Example {
  @MainActor static func value() -> Int {
      1
  }
}

// MARK: Output
struct Example {
  @MainActor
  static func value() -> Int {
    1
  }
}

// MARK: - Case ChainAfterIndent
// MARK: Input
func adjusted(_ values: [Int]) -> [Int] {
  values.map {
      $0 + 1
  }
    .filter { $0 > 0 }
}

// MARK: Output
func adjusted(_ values: [Int]) -> [Int] {
  values.map {
    $0 + 1
  }
  .filter { $0 > 0 }
}

// MARK: - Case GuardCollapseLowersTypeHeight
// MARK: Input
extension Int {

  func requirePositive() {
    guard self > 0 else {
      return
    }
  }
}

// MARK: Output
extension Int {
  func requirePositive() {
    guard self > 0 else { return }
  }
}

// MARK: - Case MultilineListRaisesTypeHeight
// MARK: Input
extension Int {
  func sum(_ first: Int,
    _ second: Int) -> Int { first + second }
}

// MARK: Output
extension Int {

  func sum(
    _ first: Int,
    _ second: Int
  ) -> Int { first + second }
}

// MARK: - Case SortingAndTypeLeading
// MARK: Input
private protocol Values {
  var longestName: Int { get }
  var longName: Int { get }
  var mid: Int { get }
  var x: Int { get }
}

// MARK: Output
private protocol Values {

  var x: Int { get }
  var mid: Int { get }
  var longName: Int { get }
  var longestName: Int { get }
}
