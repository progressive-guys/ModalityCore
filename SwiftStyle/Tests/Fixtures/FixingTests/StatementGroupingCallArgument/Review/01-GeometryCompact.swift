// MARK: - Input
import Foundation
struct Geometry {
  let fretOffsets: [CGFloat]

  func neckWidth(at offset: CGFloat) -> CGFloat { offset }
}

enum Example {

  static func run(geometry: Geometry, fretboardSize: CGSize, stringInstrument: (tuning: [Int], tag: Int), profile: (fretOverhang: CGFloat, nutLineWidth: CGFloat, fretLineWidth: CGFloat, fretRounding: CGFloat), index: Int, startFret: Int) {
    let endOffset = geometry.fretOffsets[index - startFret]
    let neckHeight = fretboardSize.height * geometry.neckWidth(at: endOffset)
    let stringCount = CGFloat(stringInstrument.tuning.count)
    let stringSpacing = neckHeight / stringCount
    let fretHeight = stringSpacing * (stringCount - 1 + 2 * profile.fretOverhang)
    let lineWidth = (index == 0 ? profile.nutLineWidth : profile.fretLineWidth) * neckHeight / 100
    let cornerRadius = min(lineWidth, fretHeight) / 2 * profile.fretRounding
  }
}

// MARK: - Output
import Foundation
struct Geometry {
  let fretOffsets: [CGFloat]

  func neckWidth(at offset: CGFloat) -> CGFloat { offset }
}

enum Example {

  static func run(geometry: Geometry, fretboardSize: CGSize, stringInstrument: (tuning: [Int], tag: Int), profile: (fretOverhang: CGFloat, nutLineWidth: CGFloat, fretLineWidth: CGFloat, fretRounding: CGFloat), index: Int, startFret: Int) {
    let endOffset = geometry.fretOffsets[index - startFret]
    let neckHeight = fretboardSize.height * geometry.neckWidth(at: endOffset)

    let stringCount = CGFloat(stringInstrument.tuning.count)

    let stringSpacing = neckHeight / stringCount
    let fretHeight = stringSpacing * (stringCount - 1 + 2 * profile.fretOverhang)
    let lineWidth = (index == 0 ? profile.nutLineWidth : profile.fretLineWidth) * neckHeight / 100
    let cornerRadius = min(lineWidth, fretHeight) / 2 * profile.fretRounding
  }
}
