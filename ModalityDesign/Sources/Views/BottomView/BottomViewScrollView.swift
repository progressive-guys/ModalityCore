#if os(iOS)
import SwiftUI
import UIKit

struct BottomViewScrollHandler: Sendable {
  var onOverscroll: @MainActor @Sendable (CGFloat) -> Void = { _ in }
  var onOverscrollEnded: @MainActor @Sendable (CGFloat, CGFloat) -> Void = { _, _ in }
}

private struct BottomViewScrollHandlerKey: EnvironmentKey {
  static let defaultValue = BottomViewScrollHandler()
}

extension EnvironmentValues {
  var bottomViewScrollHandler: BottomViewScrollHandler {
    get { self[BottomViewScrollHandlerKey.self] }
    set { self[BottomViewScrollHandlerKey.self] = newValue }
  }
}

/// A scroll view that transfers an overscroll at its top edge to its enclosing `BottomView`.
public struct BottomViewScrollView<Content: View>: UIViewControllerRepresentable {
  @Environment(\.bottomViewScrollHandler) private var scrollHandler
  private let content: () -> Content

  public init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content
  }

  public func makeUIViewController(context: Context) -> BottomViewScrollViewController<Content> {
    BottomViewScrollViewController(rootView: content(), scrollHandler: scrollHandler)
  }

  public func updateUIViewController(
    _ uiViewController: BottomViewScrollViewController<Content>,
    context: Context
  ) {
    uiViewController.scrollHandler = scrollHandler
    uiViewController.updateContent(content())
  }
}

public final class BottomViewScrollViewController<Content: View>: UIViewController {
  private let scrollView = UIScrollView()
  private var hostingController: UIHostingController<Content>
  var scrollHandler: BottomViewScrollHandler

  private var isOverscrolling = false
  private var dragStartY: CGFloat = 0
  private var overscrollTranslation: CGFloat = 0

  init(rootView: Content, scrollHandler: BottomViewScrollHandler) {
    hostingController = UIHostingController(rootView: rootView)
    self.scrollHandler = scrollHandler
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

    scrollView.alwaysBounceVertical = true
    scrollView.showsVerticalScrollIndicator = true
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(scrollView)

    addChild(hostingController)
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    hostingController.view.backgroundColor = .clear
    scrollView.addSubview(hostingController.view)
    hostingController.didMove(toParent: self)

    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      hostingController.view.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
      hostingController.view.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
    ])

    scrollView.panGestureRecognizer.addTarget(self, action: #selector(handlePan(_:)))
  }

  func updateContent(_ content: Content) {
    hostingController.rootView = content
  }

  @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
    let translation = gesture.translation(in: view)
    let velocity = gesture.velocity(in: view)

    switch gesture.state {
    case .began:
      dragStartY = scrollView.contentOffset.y
      isOverscrolling = false
      overscrollTranslation = 0
    case .changed:
      let topOffset = -scrollView.adjustedContentInset.top
      let distanceToTop = max(0, dragStartY - topOffset)
      overscrollTranslation = max(0, translation.y - distanceToTop)

      guard isOverscrolling || overscrollTranslation > 0 else { return }
      isOverscrolling = true
      scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: topOffset)
      scrollHandler.onOverscroll(overscrollTranslation)
    case .ended, .cancelled:
      if isOverscrolling {
        scrollHandler.onOverscrollEnded(overscrollTranslation, velocity.y)
      }
      isOverscrolling = false
    default:
      break
    }
  }
}
#endif
