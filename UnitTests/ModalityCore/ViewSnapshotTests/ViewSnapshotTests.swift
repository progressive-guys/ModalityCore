#if os(macOS)
import AppKit
import ModalityCore
import Testing

struct ViewSnapshotTests {
  @Test @MainActor func cropUsesItsOriginAndPixelScale() throws {
    _ = NSApplication.shared
    let view = SplitColorView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
    let window = NSWindow(contentRect: view.bounds, styleMask: .borderless, backing: .buffered, defer: false)
    window.isReleasedWhenClosed = false
    window.contentView = view
    window.orderFront(nil)
    defer { window.close() }
    let region = CGRect(x: view.bounds.midX, y: 0, width: view.bounds.width / 2, height: view.bounds.height)
    let scale = 2.0
    let png = try view.snapshotPNG(in: region, scale: scale)
    let bitmap = try #require(NSBitmapImageRep(data: png))
    #expect(bitmap.pixelsWide == Int(region.width * scale))
    #expect(bitmap.pixelsHigh == Int(region.height * scale))
    let color = try #require(bitmap.colorAt(x: bitmap.pixelsWide / 2, y: bitmap.pixelsHigh / 2)?.usingColorSpace(.sRGB))
    #expect(color.redComponent ~~== 0)
    #expect(color.greenComponent ~~== 0)
    #expect(color.blueComponent ~~== 0)
  }
}

@MainActor
private final class SplitColorView: NSView {
  override func draw(_ dirtyRect: NSRect) {
    NSColor.white.setFill()
    bounds.fill()
    NSColor.black.setFill()
    CGRect(x: bounds.midX, y: 0, width: bounds.width / 2, height: bounds.height).fill()
  }
}
#endif
