# SwiftStyle

Read [[README]] and comments in the affected configs or checker source files before changes.

- Keep the configs, checker and fixture tests in this folder. Explain each rule beside its code.
- Use English DocC comments for Swift declarations. Use English comments in configs and scripts.
- Consumer repositories select source folders and build hooks.
- Preserve evaluation order. Structural rules report errors without fixes.
- Use two-space Swift indentation. Keep existing blocks in place.
- Explain SwiftFormat and SwiftLint settings with comments in their configs.
- Diagnostic cases use `Tests/Fixtures/Diagnostics/<case>.swift`. Defaults are `Accepted: 0`, `Rejected: 1`, and successful compilation. Use an independent `<case>.json` beside the Swift file for exceptions. Each input must compile, except parser-error cases.
- Run the `SwiftStyleTests` scheme and `sh Scripts/lint.sh Sources Tests/SwiftStyleTests Project.swift` after changes.
