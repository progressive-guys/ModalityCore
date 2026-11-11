// MARK: - Input
struct Sampler {
  let displayHz: Int
  let onFrame: () -> Void

  func start() { onFrame() }
}

enum Examples {

  static func begin(onFrame: @escaping () -> Void) {
    let fallbackSampler = Sampler(
      displayHz: 60,
      onFrame: onFrame
    )


    fallbackSampler.start()
  }
}

// MARK: - Output
struct Sampler {
  let displayHz: Int
  let onFrame: () -> Void

  func start() { onFrame() }
}

enum Examples {

  static func begin(onFrame: @escaping () -> Void) {
    let fallbackSampler = Sampler(
      displayHz: 60,
      onFrame: onFrame
    )

    fallbackSampler.start()
  }
}
