// MARK: - Input
struct Document {

  private enum CodingKeys: String, CodingKey {

    case schemaVersion
  }
  let track: Track
  let schemaVersion: Int
}

struct Track {}

// MARK: - Output
struct Document {

  private enum CodingKeys: String, CodingKey {
    case schemaVersion
  }

  let track: Track
  let schemaVersion: Int
}

struct Track {}
