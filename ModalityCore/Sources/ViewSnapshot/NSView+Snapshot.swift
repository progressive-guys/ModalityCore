#if os(macOS)
import AppKit

public extension NSView {
  @MainActor func snapshotPNG(scale: Double = 1) throws -> Data {
    guard scale.isFinite, scale > 0, !bounds.isEmpty,
          let bitmap = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(ceil(bounds.width * scale)), pixelsHigh: Int(ceil(bounds.height * scale)), bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0) else { throw CocoaError(.coderInvalidValue) }
    bitmap.size = bounds.size
    layoutSubtreeIfNeeded()
    displayIfNeeded()
    cacheDisplay(in: bounds, to: bitmap)
    guard let png = bitmap.representation(using: .png, properties: [:]) else { throw CocoaError(.coderInvalidValue) }
    return png
  }
}
#endif
