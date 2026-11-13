# SwiftStyle

The previous rule engine has been removed. The replacement keeps the command-line entry point, diagnostic format, rule identifiers, Tuist plugin, and SwiftLint/SwiftFormat configs.

`Scripts/run.sh` accepts source paths, `--stdin`, `--fix`, `--json`, `--rules`, and `--filter-layout-diagnostics`. Checks report `swiftstyle_unavailable`; formatting and diagnostic filtering fail with an explicit unavailable error until the replacement engine is implemented. Input files remain unchanged.

## Fixtures

`Tests/legacy` preserves the previous fixture collection.

`Tests/confirmed` contains 56 confirmed scenarios. `Tests/discuss` contains 32 scenarios for review. Each collection retains its index, manifest, and original Swift files. Tuist displays both folders as additional files. Their expected results are not yet connected to the test runner.

The existing three test suites and loading helpers remain available. `Tests/Fixtures` has empty suite folders for the replacement tests.
