#if os(macOS)
import AppKit
import Testing
import ModalityCore

struct ImageComparisonTests {
  @Test func toleranceKeepsSmallChannelChangesAndRejectsMissingInk() throws {
    let reference = try png(width: 16, red: 128)
    let antialiasing = try ImageComparison.compare(expected: reference, actual: png(width: 16, red: 132))
    #expect(antialiasing.matches(precision: 1))
    let missingInk = try ImageComparison.compare(expected: reference, actual: png(width: 16, red: 255))
    #expect(!missingInk.matches(precision: 1))
    #expect(missingInk.changedPixels == missingInk.pixelCount)
    #expect(!missingInk.diff.isEmpty)
  }

  @Test func dimensionsMustMatchEvenWithZeroPrecision() throws {
    let comparison = try ImageComparison.compare(expected: png(width: 16, red: 128), actual: png(width: 17, red: 128))
    #expect(!comparison.matches(precision: 0))
  }

  private func png(width: Int, red: UInt8) throws -> Data {
    let bitmap = try #require(NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: width, pixelsHigh: 16, bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: width * 4, bitsPerPixel: 32))
    let bytes = try #require(bitmap.bitmapData)
    for offset in stride(from: 0, to: width * 16 * 4, by: 4) {
      bytes[offset] = red
      bytes[offset + 1] = 0
      bytes[offset + 2] = 0
      bytes[offset + 3] = 255
    }
    return try #require(bitmap.representation(using: .png, properties: [:]))
  }
}
#endif
