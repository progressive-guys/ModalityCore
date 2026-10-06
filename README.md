# ModalityCore

[![Tests](https://github.com/progressive-guys/ModalityCore/actions/workflows/package-contract.yml/badge.svg?branch=master&event=push)](https://github.com/progressive-guys/ModalityCore/actions/workflows/package-contract.yml)

![Version](https://img.shields.io/github/v/release/modality-lab/ModalityCore)
![Swift](https://img.shields.io/badge/Swift-5.9+-orange?logo=swift)
![Platforms](https://img.shields.io/badge/Platforms-iOS%2016%20%7C%20macOS%2013%20%7C%20visionOS%201-blue)
![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen)

A Swift package providing core utilities and design components for building music-related iOS, macOS, and visionOS applications.

## Products

This package provides two products:
### ModalityCore

Foundation utilities and extensions:

- **Array Extensions**: KeyPath-based aggregations (`max`, `min`, `average`, `median`, `sum`), `chunked`, Codable `RawRepresentable` conformance
- **Approximate Comparison**: Floating-point operators (`~~==`, `~~!=`, `~~<`, `~~>`, `~~<=`, `~~>=`) with ULP-based tolerance
- **Numeric Extensions**: Interpolation, extrapolation (`lerp`), normalization, formatting, sign value
- **Property Wrappers**: `@Persisted` — automatic UserDefaults sync with debouncing
- **Operators**: CGSize arithmetic, logical assignment operators (`||=`, `&&=`, `??=`)
- **Bundled resources**: `BundledResource<Content>("file.xml", bundle: bundle)` stores a relative path and bundle. `fileName` is the last path component; bundle lookup uses this file name. Use `try resource.url` to read the file.
- **File storage**: `FileSystemStore<Value>` reads and writes Codable, Sendable values as JSON at caller-supplied URLs. Writes are atomic; directory reads return `(trees: [Tree<Entry>], errors: [URL: any Error])`. Trees preserve empty folders. Consumers choose the display order. Hidden items and symbolic links are skipped. Nested file or directory failures are reported by URL while other entries remain available. A missing root returns an empty result; other root read errors propagate. Use `trees.flatMap(\.flattened)` for a flat list. A supplied decoder can fill profile defaults. Deletion uses the supplied file URL. Operations are synchronous; UI owners can run them in worker tasks.
- **Trees**: `Tree<Value>` holds folders and leaf values. `map` changes leaf values and keeps folders and order; `flattened` returns all leaf values. Protocol support depends on the value type.
- **Utilities**: `SeededRandomNumberGenerator`, debug helpers, Logger extensions

### ModalityDesign

SwiftUI design components and utilities:

- **Views**: `RangeRestrictedSlider`, `Knob`, `WedgeView`, `RingView`, `CircularLabel`, `TagsView`, `WindowOpenableButton`
- **Layouts**: `TagsLayout` (wrapping flow layout), `WidthDrivenVStack`
- **Shapes**: `WedgeShape`, `RoundedCornersRectangle`, `PlayheadShape`
- **Shaders**: Metal shaders (invert, parameterized noise)
- **Animations**: Custom transitions, `AnimatableTriplet`

## Usage

### Approximate Comparison

Standard floating-point comparison fails for accumulated rounding errors. The approximate operators handle this:

```swift
import ModalityCore

var value: Double = 1.0
for _ in 0..<10 { value -= 0.1 }

value == 0.0   // false (floating-point drift)
value ~~== 0.0 // true  (within ULP tolerance)
value ~~!= 0.0 // false
value ~~<= 0.0 // true
```

### KeyPath Aggregations

```swift
import ModalityCore

struct Score { let value: Double; let weight: Double }
let scores = [Score(value: 85, weight: 1.0), Score(value: 92, weight: 1.5)]

scores.max(\.value)       // 92.0
scores.average(\.value)   // 88.5
scores.sum(\.weight)      // 2.5

[1.0, 2.0, 3.0, 4.0, 5.0].median // 3.0
[10.0, 20.0, 30.0].chunked(into: 2) // [[10.0, 20.0], [30.0]]
```

### @Persisted Property Wrapper

```swift
import ModalityCore

@Persisted(key: "playbackSpeed", defaultValue: 1.0, debounce: 0.3)
var speed: Double

// Observe changes via Combine
$speed.sink { newSpeed in print("Speed: \(newSpeed)") }
```

## Requirements

- iOS 16.0+
- macOS 13.0+
- visionOS 1.0+
- Swift 5.9+

## Installation

### Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
  .package(url: "https://github.com/modality-lab/ModalityCore.git", branch: "master"),
]
```

Then add products to your target:

```swift
.target(
  name: "YourTarget",
  dependencies: [
    .product(name: "ModalityCore", package: "ModalityCore"),
    .product(name: "ModalityDesign", package: "ModalityCore"),
  ]
)
```

## Tuist

The libraries and tests are defined in `Package.swift`. Run from the checkout:

```sh
swift package resolve
swift test
swift build -c release
```

Open `Workspace.xcworkspace`. Tuist 4.210.0 generates the libraries and tests from `Package.swift`. The package owns products, resources, platforms and dependency requirements. SwiftMusicTheory resolves from its declared remote repository. The local `ModalityCoreProjectDescription` plugin exports test and coverage names for consumer workspace schemes.

To use local sources in another Tuist project, add this checkout and any local SwiftMusicTheory checkout as path dependencies in the consumer's `Tuist/Package.swift`. Use `.external(name: "ModalityCore")` or `.external(name: "ModalityDesign")` in its target dependencies. The consumer owns paths and package settings. A local package must keep its package identity; a consumer-owned symbolic link can provide the expected directory name.

Development and tests need Swift 6 and the Metal toolchain. CI uses the latest stable Xcode on the macOS runner and the pinned Tuist version. It runs package resolution, unit tests, a Release package build, Tuist generation and both generated unit-test schemes.
