// MARK: - Input
enum Example {

  static func fraction(_ pitch: Int, _ referencePitch: Int, _ octaveSubdivisions: Int) -> Double {
    let distanceBetweenTheCurrentlyObservedPitchAndTheReferencePitch = Double(pitch - referencePitch) / Double(
      octaveSubdivisions
    )
    return distanceBetweenTheCurrentlyObservedPitchAndTheReferencePitch
  }
}

// MARK: - Output
enum Example {

  static func fraction(_ pitch: Int, _ referencePitch: Int, _ octaveSubdivisions: Int) -> Double {
    let distanceBetweenTheCurrentlyObservedPitchAndTheReferencePitch = Double(pitch - referencePitch)
      / Double(octaveSubdivisions)
    return distanceBetweenTheCurrentlyObservedPitchAndTheReferencePitch
  }
}
