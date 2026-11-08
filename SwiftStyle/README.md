# SwiftStyle

SwiftLint and SwiftFormat configs, a SwiftSyntax checker, and fixture tests. This folder is part of ModalityCore.

## Setup

Use macOS, Xcode with Swift 6 or later, and mise. From this folder:

```sh
mise install
```

Tool versions are set in `.mise.toml`. The checker uses SwiftSyntax, SwiftParser and SwiftOperators from the active Xcode. `Scripts/run.sh` builds the command-line tool with `swiftc`. The default cache is `~/Library/Caches/SwiftStyle`; `SWIFT_STYLE_CACHE` can set another path.

The Tuist targets build for the Mac's native architecture to match Xcode's SwiftSyntax libraries.

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
sh Scripts/run.sh --fix Sources
sh Scripts/run.sh --fix --stdin < Input.swift > Output.swift
```

The script uses the configs shipped with this tool version. Set `SWIFT_STYLE_CONFIG_ROOT` to use consumer-owned configs. Without paths, the script checks the current directory. SwiftFormat, SwiftLint and the approved SwiftStyle rules run: `enum_case_blank_line`, `collapsible_nested_if`, `switch_case_pattern_indent`, `multiline_string_indent`, `arithmetic_call_arguments_wrap`, `mixed_additive_expression_wrap`, `mixed_multiplicative_expression_wrap`, `member_spacing`, `member_order`, `property_grouping`, `attribute_newline`, `private_view_properties`, `statement_grouping`, `prefer_syntax_kind_switch` and `prefer_type_switch`. Each failure returns a nonzero status. With `--fix`, SwiftFormat and SwiftLint apply their fixes first, then SwiftStyle applies fixes for the selected rules. A nonempty `CI` value other than `false` or `0` turns fixes off. Other structural rules are available through `Scripts/run.sh` for manual checks while they await approval.

The build configuration comments out SwiftFormat `indent`, SwiftLint `line_length`, and SwiftStyle `arithmetic_precedence_wrap`, `binary_operator_wrap`, `multiline_expression_closing_delimiter` and `switch_case_spacing`. Existing library sources fail these checks. The comments beside the selections state why they are disabled.

SwiftFormat `sortImports` with `--import-grouping length` orders imported module paths from short to long. Equal lengths keep their source order. Attributes and comments stay with their imports; conditional branches are sorted separately. Import hoisting is disabled.

The checker also accepts `--stdin` and `--rules name1,name2`. `--fix` writes changed files atomically. With `--fix --stdin`, standard output contains source and standard error contains remaining diagnostics; omit `--json`. A remaining diagnostic returns status 2. Layout fixes preserve tokens, comments and LF or CRLF endings. Each pass checks the syntax again. Nested `if` fixes keep condition order and binding scope. String fixes keep decoded literal values and interpolation expressions.

`complex_control_flow_condition` can move the first Boolean condition of a standalone `if` or `guard` into a local `let` with type `Swift.Bool`. It keeps the complete expression, its evaluation order and short-circuit operations. The generated name avoids names in the source file. Later conditions, bindings, `where` clauses, labels, macros and `else if` branches keep their diagnostics for review. An `if` with an `else` needs another statement in its enclosing block, to preserve implicit results. `no_global_functions` keeps reporting errors for owner review.

Property order fixes use visibility, kind, type and attribute groups. They move initializers and attached comments with each property and keep other member slots in place. Conditional branches are sorted independently. Stored-property initialization order can change. For a plain struct with known stored-property types, a generated initializer keeps the original memberwise parameter order and defaults.

Two or more consecutive type checks of the same object require `switch`. This applies to adjacent `if` statements, `else if` branches and checks within one condition. An intervening statement ends the sequence. Single checks, different objects, wrapper calls and repeated function calls keep their form. SwiftSyntax checks use `switch` over `SyntaxEnum`; separate checks keep separate receiver evaluations. Only concrete node types enter this rule; casts to syntax families such as `ExprSyntax` keep their original form. Native `as?` and `is` checks use typed switch patterns. A local switch expression keeps embedded checks in their original short-circuit conditions. Wrapper methods such as `ancestorIs` keep their calls. Checks with unsupported comment boundaries keep their diagnostics. Continued `case` patterns use two spaces from `case`. JSON output has SwiftLint diagnostic fields. Syntax errors use `swift_parser`. Rule comments are in [[Sources/SwiftStyle/StyleRule]], [[Sources/SwiftStyle/ExpressionPolicy]] and the shared configs.

`attribute_newline` puts each declaration attribute on a separate line before the declaration, at the same indentation. This applies to types, initializers, functions and computed properties. Import attributes share the import line, as in `@preconcurrency import Combine`. Comments between the attribute and import keep their positions. Stored properties use `property_grouping`, which keeps their attributes on the declaration line through column 120, including indentation. Longer stored-property lines put the attributes above the declaration. Properties with `willSet` or `didSet` use the stored-property rule. Comments and line breaks inside attribute arguments keep their positions. Type attributes such as `@escaping` and `@Sendable` stay within the type expression. Multiline properties use one blank line on each side.

Stored-property groups use one blank line on each side when they contain more than three properties. Stored `let` and `var` declarations always use one blank line between them, including static properties. Small groups of single-line properties stay together. After groups are formed, each block between blank lines is sorted by its longest declaration line, without leading indentation. Visibility, static/let/var/attribute kind and attribute names keep priority over length; type does not. Attribute groups follow their first occurrence. Within each block, declarations of the same attribute group are sorted by length. Equal lengths keep their order. A struct keeps its synthesized initializer when the checker cannot determine its parameter types, such as unresolved property wrappers. These order errors remain for review.

`member_order` uses this section order: `typealias`, nested type declarations (including `associatedtype`), stored properties, `init`, `deinit`, `subscript`, computed properties, then functions. Properties with observers are stored. Complete declarations move with their comments. Other member slots and file-scope extension locations stay in place. A conditional block whose members all belong to one section and one effect group moves as a complete unit, with its conditions and branches intact. Mixed blocks keep their boundary; each branch is checked on its own. Within computed-property and function sections, declarations use this effect order: plain, `throws`/`rethrows`, `async`, then `async throws`/`async rethrows`. Properties use getter effects. Effect groups use one blank line between them. Each group keeps source order, including protocol requirements. Single-line members stay together; multiline members use one blank line. A leading group comment starts a separate group.

`member_spacing` keeps nested types one blank line from adjacent declarations. Type and extension bodies with at most three code lines have no blank line after the opening brace. Longer bodies start with one blank line. `statement_grouping` removes opening blank lines from executable bodies of any length: functions, initializers, deinitializers, closures, accessors and control-flow bodies. A closure body starts after `in` when it has a signature. The count for type bodies includes nested code and excludes the outer braces, blank lines and comments.

`multiline_string_indent` aligns contents and closing quotes with opening quotes that start a line, including raw literals. When opening quotes follow code on the same line, contents and closing quotes use two extra spaces from that line. It preserves raw text, escapes and string values. Multiline interpolation expressions keep their diagnostic. SwiftFormat `semicolons` with `--semicolons never` separates inline statements. `statement_grouping` keeps consecutive local uses together across multiline expressions, conditions, branches, loops and closure captures. Derived bindings and successful guard bindings extend the group. References respect lexical scope and shadowing. Consecutive single-line declarations start one preparation group. Independent declarations, leading comments and conditional compilation boundaries start another group. A call that combines values from separate preparation groups starts a shared use group. Statement order stays unchanged.

`private_view_properties` requires private instance properties in structs that explicitly conform to `View` or `SwiftUI.View`, except `body`. It keeps explicit initializers and can generate a known memberwise signature, including `Binding` inputs. Private optional `State` values keep their implicit nil initialization. Unknown wrappers, conditional stored declarations and additional protocol conformances keep diagnostics when a safe initializer or access change cannot be determined.

Groups use local declarations from the current body. Parameters and outer properties are inputs to that body. An independent operation ends the immediate declaration-use chain. Other pairs of ordinary actions, including calls on different receivers, allow zero or one blank line. Reuse of an older local value follows this spacing. A call that combines preparation groups still requires a separator. Other statements keep kind-based spacing. Bodies with at most three code lines keep statements together. This takes priority over dependency groups, statement kinds and manual separators. A leading group comment keeps its separator. The count includes nested code and excludes outer braces, blank lines and comments. Each nested body has its own count. `compact_else_blank_line` follows these group boundaries after a guard.

A standalone `switch` connects to the preceding group through its subject. Values used only in its branches keep a blank line before the switch. A switch expression used to compute a value includes branch inputs. Closure captures include uses inside nested switches.

Two adjacent multiline statements in a dependency group allow zero or one blank line. The separator keeps both statements in the same group. Extra blank lines are reduced to one.

Consecutive single-line assignments with `=` use no blank lines, at any group length. This takes priority over dependency boundaries and manual separators. A leading group comment, call, declaration or multiline statement ends the assignment group.

An assignment followed by an `if` or `guard` stays beside the check when its conditions read the changed variable or property path. This includes standard compound assignment operators. Conditions respect shadowing and compare full property paths. An intervening operation or group comment ends the connection. Two multiline operations can keep one blank line.

A local declaration stays beside the next `if` or `guard` when its conditions read the declared value, including checks that use values from earlier preparation groups. Two multiline operations can keep one blank line. A leading group comment keeps its separator.

## Tests

```sh
mise exec -- tuist install
mise exec -- tuist generate --no-open
xcodebuild test -workspace SwiftStyle.xcworkspace -scheme SwiftStyleTests -destination 'platform=macOS' CODE_SIGNING_ALLOWED=NO
```

The checker project loads its local `ModalityBuild` plugin. Its lint script path is relative to its own manifest, so cached helpers also use this checkout.

The scheme runs three parameterized tests with all SwiftStyle rules:

| Suite | Check | Fixture content |
|---|---|---|
| `AcceptingTests` | Source compiles without diagnostics and stays unchanged after fixes | Swift source |
| `FixingTests` | Fixed source matches the independent Output; Input and Output compile; Output has no diagnostics and stays unchanged after fixes | Input and Output sections |
| `DecliningTests` | Expected rule IDs are reported; fixes preserve the source and diagnostics | Swift source |

The suite names describe the checker's response to the input. Declining reports a violation that remains after a fix attempt.

Each scenario is one named file under `Tests/Fixtures/<Suite>/`. Accepting fixtures use `<Rule>/<Behavior>.swift`: one scenario and its required declarations. Declarations stay together when the test checks their interaction. The relative path identifies the case in test results. Fixing and declining fixtures contain their scenario and its required declarations; the suite defines the expected behavior of the complete input. The same tests cover LF and CRLF. Diagnostic expectations are declared in the suite; counts and source positions are checked only when required by a scenario. Parser-error inputs may be invalid Swift.

Fixing fixtures start with `// MARK: - Input`. A blank line followed by `// MARK: - Output` starts the expected output. The fixture loader removes the markers and the separating blank line. It preserves source whitespace, including the final newline. Each fixing file has exactly one output separator. Fixtures use LF; the tests also derive CRLF variants.

Tuist uses the shared `ResourceSynthesizers/Files.stencil` to generate `Derived/Sources/TuistFiles+SwiftStyleTests.swift`. The template finds suites by matching each test file name to its folder name. Generated `Files.<Suite>.files` properties return `[BundledResource<SwiftFixture>]`. The common resource type lists files recursively in path order from `SwiftStyleFixtures.bundle`. The test target depends on the native ModalityCore project in the parent directory. `SwiftFixture` reads UTF-8 source. The fixture loader checks Input/Output sections and preserves source whitespace. Add a fixture file to add a case. Declining cases also declare their expected rule IDs in the suite.

`FixingTests` checks each expected Output directly: it must compile, have no diagnostics and stay unchanged. `AcceptingTests` covers additional valid forms and rule exceptions. Import fixtures check that attributes, conditional branches and file sections stay unchanged; string fixtures include semicolons inside literals. Both suites run the SwiftStyle executable with all its rules.

The `Tests/SwiftStyleTests` buildable folder provides test sources and inputs for resource generation. The `SwiftStyleFixtures` target copies `Tests/Fixtures` as a folder reference with one native Copy Files phase. The bundle stores files under `Fixtures/` with their relative paths. `SwiftStyleProject` in the parent repository's `Tuist/Plugins/ModalityCoreBuild` declares the targets used by both the project and workspace. Tuist resolves the fixture path relative to `SwiftStyle/Project.swift`. The test target embeds the resource bundle with a native Copy Files phase. The process helper drains standard output and standard error concurrently. Fixture sources are excluded from normal style checks. These tests run the SwiftStyle executable. SwiftFormat and SwiftLint run through the separate lint command.

## Tuist plugin

`Plugin.swift` exports `ModalityBuild`. A consumer declares the ModalityCore Git URL, `sha: "refs/tags/1.1.1"` and `directory: "SwiftStyle"` in `Tuist.swift`. Tuist 4.210.0 treats the root `Package.swift` as an executable plugin when using `tag:`. The `sha:` loader accepts a Git tag reference and loads the source plugin from `SwiftStyle`. ModalityCore loads the plugin from its own `SwiftStyle` directory. Run `tuist install` before `tuist generate --no-open`. The plugin includes its configs, checker and scripts. It needs Xcode and mise. The script selects the tool versions from this directory's `.mise.toml`.

`Project.linted` adds the same checks before compilation for each target's `lintPaths`. It runs on every build. `TargetDependency.library` uses a package product by default. A consumer can set `TUIST_LOCAL_PROJECTS_ROOT` to the absolute directory that contains its local projects. Use the `package` argument when a product name differs from its repository name. The Modality root sets this option in its `.mise.toml`; standalone checkouts leave it unset.

The SwiftStyle executable and test targets use `Target.withLint(paths:)` from the selected plugin. The phase builds its checker through `swiftc` and the script cache, so it does not start another Xcode build. Each target checks its own source folder; diagnostic fixtures remain excluded.
