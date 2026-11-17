# SwiftStyle

The previous rule engine has been removed. The replacement keeps the command-line entry point, diagnostic format, rule identifiers, Tuist plugin, and SwiftLint/SwiftFormat configs.

`Scripts/run.sh` accepts source paths, `--stdin`, `--fix`, `--json`, `--rules`, and `--filter-layout-diagnostics`. Checks report `swiftstyle_unavailable`; formatting and diagnostic filtering fail with an explicit unavailable error until the replacement engine is implemented. Input files remain unchanged.

## Fixtures

`Tests/Fixtures/<Rule>/` contains the reviewed fixtures. Each rule folder uses `Accepting.swift`, `Fixing.swift`, and `Declining.swift` (or `Declined.swift`). Nested scenario folders use the same names.

Tuist copies this directory into the test bundle as resources. The three test suites select files by name. The existing test suites start with the reviewed files; formatter checks fail until the replacement engine is implemented. Some files retain the review format with several scenarios and `/// Output` markers; the current loader expects one `// MARK: Input` / `// MARK: Output` pair.

Build lint runs SwiftFormat and SwiftLint. The unavailable SwiftStyle engine is checked through its CLI and fixture tests.
