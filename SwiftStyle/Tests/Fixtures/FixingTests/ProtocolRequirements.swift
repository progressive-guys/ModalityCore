// MARK: - Input
protocol Example {
  var playbackState: MetronomePlaybackState { get }

  var currentMeasure: Measure? { get set }
  var loopedAddress: ((TimeSliceAddress) -> TimeSliceAddress?)? { get set }
  var currentBeat: Int { get }
  var isTrackLoopEnabled: (() -> Bool)? { get set }
}

typealias MetronomePlaybackState = Int
struct Measure {}
struct TimeSliceAddress {}

protocol SourceOrder {
  var longerName: Int { get }
  var b: Int { get }
  var a: Int { get }
  var title: String { get }
}

protocol CommentGroup {
  // Values.
  var zzzz: Int { get }
  var b: Int { get }
  var aa: Int { get }
  var ccc: Int { get }
  var tiny: String { get }
}

// MARK: - Output
protocol Example {

  var playbackState: MetronomePlaybackState { get }
  var currentMeasure: Measure? { get set }
  var loopedAddress: ((TimeSliceAddress) -> TimeSliceAddress?)? { get set }
  var currentBeat: Int { get }
  var isTrackLoopEnabled: (() -> Bool)? { get set }
}

typealias MetronomePlaybackState = Int
struct Measure {}
struct TimeSliceAddress {}

protocol SourceOrder {

  var longerName: Int { get }
  var b: Int { get }
  var a: Int { get }
  var title: String { get }
}

protocol CommentGroup {

  // Values.
  var zzzz: Int { get }
  var b: Int { get }
  var aa: Int { get }
  var ccc: Int { get }
  var tiny: String { get }
}
