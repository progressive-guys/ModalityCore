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

Property order fixes use visibility, kind, type and attribute groups. They move initializers and attached comments with each property and keep other member slots in place. Conditional branches are sorted independently. Stored-property initialization order can change. For a plain struct with known stored-property types, a generated initializer keeps the original memberwise parameter order and defaults.

Two or more consecutive type checks of the same object require `switch`. This applies to adjacent `if` statements, `else if` branches and checks within one condition. An intervening statement ends the sequence. Single checks, different objects, wrapper calls and repeated function calls keep their form. SwiftSyntax checks use `switch` over `SyntaxEnum`; separate checks keep separate receiver evaluations. Only concrete node types enter this rule; casts to syntax families such as `ExprSyntax` keep their original form. Native `as?` and `is` checks use typed switch patterns. A local switch expression keeps embedded checks in their original short-circuit conditions. Wrapper methods such as `ancestorIs` keep their calls. Checks with unsupported comment boundaries keep their diagnostics. Continued `case` patterns use two spaces from `case`. JSON output has SwiftLint diagnostic fields. Syntax errors use `swift_parser`. Rule comments are in [[Sources/SwiftStyle/StyleRule]], [[Sources/SwiftStyle/ExpressionPolicy]] and the shared configs.

`attribute_newline` puts each declaration attribute on a separate line before the declaration, at the same indentation. This applies to types, initializers, functions and computed properties. Import attributes share the import line, as in `@preconcurrency import Combine`. Comments between the attribute and import keep their positions. Stored properties use `property_grouping`, which keeps their attributes on the declaration line through column 120, including indentation. Longer stored-property lines put the attributes above the declaration. Properties with `willSet` or `didSet` use the stored-property rule. Comments and line breaks inside attribute arguments keep their positions. Type attributes such as `@escaping` and `@Sendable` stay within the type expression. Multiline properties use one blank line on each side.

Stored-property groups use one blank line on each side when they contain more than three properties. Stored `let` and `var` declarations always use one blank line between them, including static properties. Small groups of single-line properties stay together. After groups are formed, each block between blank lines is sorted by its longest declaration line, without leading indentation. Visibility, static/let/var/attribute kind and attribute names keep priority over length; type does not. Attribute groups follow their first occurrence. Within each block, declarations of the same attribute group are sorted by length. Equal lengths keep their order. A struct keeps its synthesized initializer when the checker cannot determine its parameter types, such as unresolved property wrappers. These order errors remain for review.

`member_order` uses this section order: `typealias`, nested type declarations (including `associatedtype`), stored properties, `init`, `deinit`, `subscript`, computed properties, then functions. Properties with observers are stored. Complete declarations move with their comments. Other member slots and file-scope extension locations stay in place. A conditional block whose members all belong to one section and one effect group moves as a complete unit, with its conditions and branches intact. Mixed blocks keep their boundary; each branch is checked on its own. Within computed-property and function sections, declarations use this effect order: plain, `throws`/`rethrows`, `async`, then `async throws`/`async rethrows`. Properties use getter effects. Effect groups use one blank line between them. Each group keeps source order, including protocol requirements. Single-line members stay together; multiline members use one blank line. A leading group comment starts a separate group.

`private_view_properties` requires private instance properties in structs that explicitly conform to `View` or `SwiftUI.View`, except `body`. It keeps explicit initializers and can generate a known memberwise signature, including `Binding` inputs. Private optional `State` values keep their implicit nil initialization. Unknown wrappers, conditional stored declarations and additional protocol conformances keep diagnostics when a safe initializer or access change cannot be determined.

`member_spacing` keeps nested types one blank line from adjacent declarations. Type and extension bodies with at most three code lines have no blank line after the opening brace. Longer bodies start with one blank line.

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
