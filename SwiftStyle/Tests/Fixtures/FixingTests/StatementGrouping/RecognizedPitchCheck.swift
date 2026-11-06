// MARK: - Input
enum Examples {

  static func match(
    _ pitches: [(note: Int, octave: Int)],
    note: Int,
    octave: Int,
    consumed: inout Set<Int>
  ) -> Int? {
    for index in pitches.indices {
      let recognized = pitches[index]

      if recognized.note == note,
         recognized.octave == octave,
         !consumed.contains(index)
      {
        consumed.insert(index)
        return index
      }
    }

    return nil
  }
}

// MARK: - Output
enum Examples {

  static func match(
    _ pitches: [(note: Int, octave: Int)],
    note: Int,
    octave: Int,
    consumed: inout Set<Int>
  ) -> Int? {
    for index in pitches.indices {
      let recognized = pitches[index]
      if recognized.note == note,
         recognized.octave == octave,
         !consumed.contains(index)
      {
        consumed.insert(index)
        return index
      }
    }

    return nil
  }
}
