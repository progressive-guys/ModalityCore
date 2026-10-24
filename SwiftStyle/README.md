# SwiftStyle

SwiftLint and SwiftFormat configs, a SwiftSyntax checker, and fixture tests. This folder is part of ModalityCore.

## Setup

Use macOS, Xcode with Swift 6 or later, and mise. From this folder:

```sh
mise install
```

Tool versions are set in `.mise.toml`. The checker uses SwiftSyntax, SwiftParser and SwiftOperators from the active Xcode. `Scripts/run.sh` builds the command-line tool with `swiftc`. The default cache is `~/Library/Caches/SwiftStyle`; `SWIFT_STYLE_CACHE` can set another path.

## Modality integration

Modality uses its existing ModalityCore submodule. The main repository links the shared configs:

```text
.swiftlint.yml -> Modules/Open-source/ModalityCore/SwiftStyle/.swiftlint.yml
.swiftformat  -> Modules/Open-source/ModalityCore/SwiftStyle/.swiftformat
```

From the main repository root:

```sh
mise install
sh Tuist/Scripts/lint.sh
```

The main repository includes this folder's `.mise.toml` in its root config. The main repository selects source folders and build hooks. Root config links keep editor support. Library checkouts keep their own build and CI setup.

## Checks

```sh
sh Scripts/lint.sh Sources Tests/SwiftStyleTests Project.swift
sh Scripts/lint.sh --fix Sources Tests/SwiftStyleTests Project.swift
sh Scripts/run.sh --json Sources
```

The script uses the configs shipped with this tool version. Set `SWIFT_STYLE_CONFIG_ROOT` to use consumer-owned configs. Without paths, the script checks the current directory. SwiftFormat, SwiftLint and the approved SwiftStyle rules run: `enum_case_blank_line`, `collapsible_nested_if`, `arithmetic_call_arguments_wrap`, `mixed_additive_expression_wrap`, `mixed_multiplicative_expression_wrap` and `prefer_syntax_kind_switch`. Each failure returns a nonzero status. With `--fix`, SwiftFormat and SwiftLint apply their fixes first. A nonempty `CI` value other than `false` or `0` turns fixes off. Other structural rules are available through `Scripts/run.sh` for manual checks while they await approval.

The build configuration comments out SwiftFormat `indent`, SwiftLint `line_length`, and SwiftStyle `arithmetic_precedence_wrap`, `binary_operator_wrap`, `multiline_expression_closing_delimiter` and `switch_case_spacing`. Existing library sources fail these checks. The comments beside the selections state why they are disabled.

The checker also accepts `--stdin` and `--rules name1,name2`. JSON output has SwiftLint diagnostic fields. Syntax errors use `swift_parser`. Rule comments are in [[Sources/SwiftStyle/StyleRule]], [[Sources/SwiftStyle/ExpressionPolicy]] and the shared configs.

## Tests

```sh
tuist generate --no-open
xcodebuild test -workspace SwiftStyle.xcworkspace -scheme SwiftStyleTests -destination 'platform=macOS' CODE_SIGNING_ALLOWED=NO
```

The `SwiftStyleTests` scheme checks SwiftStyle diagnostics with LF and CRLF line endings:

```text
Tests/Fixtures/Diagnostics/
  <case>.swift
  <case>.json (optional)
```

Diagnostic tests use the built SwiftStyle executable. Each input groups examples under named `// MARK: - <section>` sections. Types use the section name, such as `Accepted` or `Rejected`. The Swift file name without its extension sets the rule. Defaults are zero diagnostics for `Accepted`, one for `Rejected`, and successful compilation. An optional JSON file with the same name sets only exceptions: `counts` for additional sections or changed counts, and `compilerSucceeds` when compilation must fail. A null count requires at least one diagnostic. Tests check each section, including sections that must have no diagnostics. SwiftStyle reports errors and has no fixes.

The tests run `swiftc -typecheck` on every input. Only explicit parser-error cases must fail compilation. Fixture files are copied as resources. Comments in `.swiftformat` and `.swiftlint.yml` explain the native tool settings.

## Tuist plugin

`Plugin.swift` exports `ModalityBuild`. A consumer declares the ModalityCore Git URL, a fixed commit SHA and `directory: "SwiftStyle"` in `Tuist.swift`. Run `tuist install` before `tuist generate --no-open`. ModalityCore can use its own `SwiftStyle` directory as a local plugin. The plugin includes its configs, checker and scripts. It needs Xcode and mise; the script selects the tool versions from this directory's `.mise.toml`.

`Project.linted` adds the same checks before compilation for each target's `lintPaths`. It runs on every build. `TargetDependency.library` uses a package product by default. A consumer can set `TUIST_LOCAL_PROJECTS_ROOT` to the absolute directory that contains its local projects. Use the `package` argument when a product name differs from its repository name. The Modality root sets this option in its `.mise.toml`; standalone checkouts leave it unset.

SwiftStyle's own executable target does not run this phase because it builds the checker used by the phase.
