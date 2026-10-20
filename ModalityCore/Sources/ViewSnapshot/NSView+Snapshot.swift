#if os(macOS)
import AppKit

public extension NSView {
  @MainActor func snapshotPNG(in rect: CGRect? = nil, scale: Double = 1) throws -> Data {
    let rect = rect ?? bounds
    try NumericValidation.validate(scale, named: "Device scale", constraint: .positive)
    guard !rect.isEmpty, bounds.contains(rect),
          let bitmap = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(ceil(rect.width * scale)), pixelsHigh: Int(ceil(rect.height * scale)), bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0) else { throw CocoaError(.coderInvalidValue) }
    bitmap.size = rect.size
    layoutSubtreeIfNeeded()
    displayIfNeeded()
    cacheDisplay(in: rect, to: bitmap)
    guard let png = bitmap.representation(using: .png, properties: [:]) else { throw CocoaError(.coderInvalidValue) }
    return png
  }
}
#endif
