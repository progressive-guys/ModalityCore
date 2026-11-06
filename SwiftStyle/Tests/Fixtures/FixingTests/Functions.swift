// MARK: - Input
protocol Example {
  func startPlayback(from address: TimeSliceAddress, countIn: Bool, at time: DispatchWallTime)
  func countIn(duration: TimeInterval)
  func stop()
}

struct Methods {
  // Calls.
  func longerName() -> Int { 1 }

  func a() -> Int { 2 }

  func multiline() -> Int {
    3
  }
  func b() -> Int { 4 }
}

typealias TimeSliceAddress = Int
typealias DispatchWallTime = Double
typealias TimeInterval = Double

extension Methods {
  #if os(macOS)
  func longerMacName() -> Int { 5 }

  func c() -> Int { 6 }
  #else
  func longerOtherName() -> Int { 7 }
  func d() -> Int { 8 }
  #endif
}

// MARK: - Output
protocol Example {
  func startPlayback(from address: TimeSliceAddress, countIn: Bool, at time: DispatchWallTime)
  func countIn(duration: TimeInterval)
  func stop()
}

struct Methods {

  // Calls.
  func longerName() -> Int { 1 }
  func a() -> Int { 2 }

  func multiline() -> Int {
    3
  }

  func b() -> Int { 4 }
}

typealias TimeSliceAddress = Int
typealias DispatchWallTime = Double
typealias TimeInterval = Double

extension Methods {

  #if os(macOS)
  func longerMacName() -> Int { 5 }
  func c() -> Int { 6 }
  #else
  func longerOtherName() -> Int { 7 }
  func d() -> Int { 8 }
  #endif
}
