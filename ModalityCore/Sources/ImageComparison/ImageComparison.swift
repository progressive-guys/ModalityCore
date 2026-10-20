#if os(macOS)
import AppKit
import CoreGraphics
import ImageIO

public struct ImageComparison {
  public let dimensionsMatch: Bool
  public let changedPixels: Int
  public let pixelCount: Int
  public let diff: Data

  public func matches(precision: Double) -> Bool {
    dimensionsMatch && pixelCount > 0 && Double(changedPixels) / Double(pixelCount) <= 1 - precision
  }

  public static func compare(expected: Data, actual: Data, channelTolerance: Int = 8) throws -> Self {
    let left = try image(expected)
    let right = try image(actual)
    let width = max(left.width, right.width)
    let height = max(left.height, right.height)
    let reference = try pixels(left, width: width, height: height)
    let candidate = try pixels(right, width: width, height: height)
    var changed = 0
    var difference = candidate
    for offset in stride(from: 0, to: reference.count, by: 4) {
      let differs = (0..<4).contains { abs(Int(reference[offset + $0]) - Int(candidate[offset + $0])) > channelTolerance }
      if differs { changed += 1 }
      difference[offset] = differs ? 255 : reference[offset] / 3
      difference[offset + 1] = differs ? 0 : reference[offset + 1] / 3
      difference[offset + 2] = differs ? 0 : reference[offset + 2] / 3
      difference[offset + 3] = 255
    }
    guard let bitmap = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: width, pixelsHigh: height, bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: width * 4, bitsPerPixel: 32),
          let destination = bitmap.bitmapData else { throw ImageError.invalidBitmap }
    difference.withUnsafeBufferPointer { bytes in
      if let source = bytes.baseAddress { destination.update(from: source, count: bytes.count) }
    }
    guard let diff = bitmap.representation(using: .png, properties: [:]) else { throw ImageError.invalidBitmap }
    return Self(dimensionsMatch: left.width == right.width && left.height == right.height, changedPixels: changed, pixelCount: width * height, diff: diff)
  }

  private static func image(_ data: Data) throws -> CGImage {
    guard let source = CGImageSourceCreateWithData(data as CFData, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else { throw ImageError.invalidPNG }
    return image
  }

  private static func pixels(_ image: CGImage, width: Int, height: Int) throws -> [UInt8] {
    var result = [UInt8](repeating: 0, count: width * height * 4)
    try result.withUnsafeMutableBytes { bytes in
      guard let context = CGContext(data: bytes.baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: CGColorSpace(name: CGColorSpace.sRGB) ?? CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else { throw ImageError.invalidBitmap }
      context.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
    }
    return result
  }

  private enum ImageError: Error {
    case invalidPNG
    case invalidBitmap
  }
}
#endif
