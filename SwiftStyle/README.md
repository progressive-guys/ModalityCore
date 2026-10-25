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

The main repository includes this folder's `.mise.toml` in its root config. Its `Tuist.swift` selects this folder as a local `ModalityBuild` plugin. Its mise config sets `TUIST_SWIFT_STYLE_ROOT` to this folder's absolute path, so cached helpers also use the current scripts, configs and checker. The main repository selects source folders and build hooks. Root config links keep editor support. Standalone checkouts select the fixed Git plugin version in their own `Tuist.swift` and leave `TUIST_SWIFT_STYLE_ROOT` unset.

## Checks

```sh
sh Scripts/lint.sh Sources Tests/SwiftStyleTests Project.swift
sh Scripts/lint.sh --fix Sources Tests/SwiftStyleTests Project.swift
sh Scripts/run.sh --json Sources
```

The script uses the configs shipped with this tool version. Set `SWIFT_STYLE_CONFIG_ROOT` to use consumer-owned configs. Without paths, the script checks the current directory. SwiftFormat, SwiftLint and the approved SwiftStyle rules run: `enum_case_blank_line`, `collapsible_nested_if`, `arithmetic_call_arguments_wrap`, `mixed_additive_expression_wrap`, `mixed_multiplicative_expression_wrap`, `member_spacing`, `property_grouping`, `statement_grouping`, `prefer_syntax_kind_switch` and `prefer_type_switch`. Each failure returns a nonzero status. With `--fix`, SwiftFormat and SwiftLint apply their fixes first. A nonempty `CI` value other than `false` or `0` turns fixes off. Other structural rules are available through `Scripts/run.sh` for manual checks while they await approval.

The build configuration comments out SwiftFormat `indent`, SwiftLint `line_length`, and SwiftStyle `arithmetic_precedence_wrap`, `binary_operator_wrap`, `multiline_expression_closing_delimiter` and `switch_case_spacing`. Existing library sources fail these checks. The comments beside the selections state why they are disabled.

The checker also accepts `--stdin` and `--rules name1,name2`. JSON output has SwiftLint diagnostic fields. Syntax errors use `swift_parser`. Rule comments are in [[Sources/SwiftStyle/StyleRule]], [[Sources/SwiftStyle/ExpressionPolicy]] and the shared configs.

## Tests

```sh
mise exec -- tuist install
mise exec -- tuist generate --no-open
xcodebuild test -workspace SwiftStyle.xcworkspace -scheme SwiftStyleTests -destination 'platform=macOS' CODE_SIGNING_ALLOWED=NO
```

The `SwiftStyleTests` scheme checks SwiftStyle diagnostics with LF and CRLF line endings:

```text
Tests/Fixtures/Diagnostics/
  <case>.swift
  <case>.json (optional)
```

Diagnostic tests use the built SwiftStyle executable. Each input has one top-level `enum Accepted` and one `enum Rejected`, with named methods or member types as cases, plus nested helper types. SwiftSyntax checks this structure. File-scope functions and extensions stay at file scope when the rule needs them. The `// MARK: - Accepted` and `// MARK: - Rejected` markers assign diagnostic lines to groups; a marker can repeat for an extension. The Swift file name without its extension sets the rule. Defaults are zero diagnostics for `Accepted`, one for `Rejected`, and successful compilation. An optional JSON file with the same name sets exceptions: `counts` changes group counts, `caseCounts` checks named methods or types such as `Rejected.MissingStaticGroupGap`, and `compilerSucceeds` marks parser-error inputs. A null count requires at least one diagnostic. Tests check every group, including groups that must have no diagnostics. SwiftStyle reports errors and has no fixes.

The tests run `swiftc -typecheck` on every input. Only explicit parser-error cases must fail compilation. Fixture files are copied as resources. Comments in `.swiftformat` and `.swiftlint.yml` explain the native tool settings.

## Tuist plugin

`Plugin.swift` exports `ModalityBuild`. A consumer declares the ModalityCore Git URL, `sha: "refs/tags/1.1.1"` and `directory: "SwiftStyle"` in `Tuist.swift`. Tuist 4.210.0 treats the root `Package.swift` as an executable plugin when using `tag:`. The `sha:` loader accepts a Git tag reference and loads the source plugin from `SwiftStyle`. ModalityCore uses the same Git plugin. Run `tuist install` before `tuist generate --no-open`. The plugin includes its configs, checker and scripts. It needs Xcode and mise; the script selects the tool versions from this directory's `.mise.toml`.

`Project.linted` adds the same checks before compilation for each target's `lintPaths`. It runs on every build. `TargetDependency.library` uses a package product by default. A consumer can set `TUIST_LOCAL_PROJECTS_ROOT` to the absolute directory that contains its local projects. Use the `package` argument when a product name differs from its repository name. The Modality root sets this option in its `.mise.toml`; standalone checkouts leave it unset.

The SwiftStyle executable and test targets use `Target.withLint(paths:)` from the selected plugin. The phase builds its checker through `swiftc` and the script cache, so it does not start another Xcode build. Each target checks its own source folder; diagnostic fixtures remain excluded.
