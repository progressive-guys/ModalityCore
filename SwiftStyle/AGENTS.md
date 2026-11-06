# SwiftStyle

Read [[README]] and comments in the affected configs or checker source files before changes.

- Keep the configs, checker and fixture tests in this folder. Explain each rule beside its code.
- Use English DocC comments for Swift declarations. Use English comments in configs and scripts.
- Consumer repositories select source folders and build hooks.
- Preserve evaluation order. Fixes must have a defined syntax change and fixture tests. Rules that need an owner decision keep reporting diagnostics.
- Use two-space Swift indentation. Keep existing blocks in place.
- Explain SwiftFormat and SwiftLint settings with comments in their configs.
- Keep one named Swift fixture per scenario in `Tests/Fixtures/<Suite>/`. Group accepting fixtures in rule folders; name each file for the behavior it checks.
- Use three parameterized suites: AcceptingTests, FixingTests and DecliningTests. Run SwiftStyle with all rules.
- Fixing fixtures start with `// MARK: - Input`. One blank line and `// MARK: - Output` separate the independent expected output. Compare the fixed input with the expected output and typecheck both. Check that Output has no diagnostics and stays unchanged after fixes.
- Declining fixtures contain source and expect the rule IDs declared in the suite. Fixes preserve the input and its diagnostics. Parser-error inputs may be invalid Swift.
- Accepting fixtures contain source that compiles without diagnostics and stays unchanged after fixes.
- Tuist generates typed Files.<Suite>.files properties from the shared Files template. The SwiftStyleFixtures resource target copies fixtures with their relative paths; the test target embeds its bundle. BundledResource<SwiftFixture> lists and reads bundled files with their relative paths; formatting loading removes section markers and preserves source whitespace. Fixture files use LF; tests also check CRLF.
- Keep each unchanged fixture to one scenario and its required declarations. Keep declarations together when their interaction is the test case. LF and CRLF use the same independent expected output.
- Place correct, unchanged examples in AcceptingTests. Fixing and declining fixtures contain their scenario and the declarations it needs. The suite defines the expected behavior of the complete input.
- Run the `SwiftStyleTests` scheme and `sh Scripts/lint.sh Sources Tests/SwiftStyleTests Project.swift ProjectDescriptionHelpers Tuist/Package.swift` after changes.
