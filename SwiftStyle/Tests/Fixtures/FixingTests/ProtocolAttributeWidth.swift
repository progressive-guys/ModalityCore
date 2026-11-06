// MARK: - Input
protocol FitsLimit {
  @MainActor
  func loadTune(_ identifier: String, includeMuted: Bool, useCache: Bool, includeArchived: Bool) async -> Int
}

protocol ExceedsLimit {
  @MainActor func loadTrack(_ identifier: String, includeMuted: Bool, useCache: Bool, includeArchived: Bool) async -> Int
}

// MARK: - Output
protocol FitsLimit {
  @MainActor func loadTune(_ identifier: String, includeMuted: Bool, useCache: Bool, includeArchived: Bool) async -> Int
}

protocol ExceedsLimit {
  @MainActor
  func loadTrack(_ identifier: String, includeMuted: Bool, useCache: Bool, includeArchived: Bool) async -> Int
}
