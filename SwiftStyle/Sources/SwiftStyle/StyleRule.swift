/// Structural rules that report errors without automatic fixes.
///
/// Rule checks define their exceptions. SwiftLint disable directives apply to native SwiftLint rules.
enum StyleRule: String, CaseIterable {

  /// Keep ?? operands on one line, or put each continuation on a new line with a leading ??. Keep nested groups
  /// together.
  case mixedNilCoalescingWrap = "mixed_nil_coalescing_wrap"

  /// Keep let or var, the variable name, = and if on the same line. Conditions and call arguments can continue on
  /// later lines.
  case ifExpressionBindingSameLine = "if_expression_binding_same_line"

  /// Indent continued if-expression conditions two spaces from the variable declaration. Ignore line breaks
  /// inside call arguments and parenthesized groups.
  case ifExpressionConditionIndent = "if_expression_condition_indent"

  /// Put the opening brace on a separate line after wrapped conditions or operands. Ignore line breaks inside
  /// call arguments.
  case multilineIfBrace = "multiline_if_brace"

  /// Keep ) and { on the same line when only call arguments wrap in the condition.
  case ifArgumentBraceNewline = "if_argument_brace_newline"

  /// Keep comma-separated if conditions on one line, or put each condition on a separate line.
  case mixedIfConditions = "mixed_if_conditions"

  /// Combine nested if conditions when the outer body contains only the inner if and neither has else.
  /// Keep the condition order. Statements before or after the inner if prevent this change.
  case collapsibleNestedIf = "collapsible_nested_if"

  /// Keep compact switch cases together. Use one blank line if either adjacent case spans multiple lines.
  /// Count attached comments as part of each case. Put separation before leading comments.
  case switchCaseSpacing = "switch_case_spacing"

  /// Keep adjacent single-line methods and protocol requirements of the same kind together.
  /// Use one blank line if either member spans multiple lines, including comments and attributes.
  /// Properties, methods, initializers, subscripts and associated types form separate groups.
  /// Put one blank line after the opening brace of a nonempty type or extension. MARK comments start new groups.
  case memberSpacing = "member_spacing"

  /// Group properties by read visibility, static/let/var/attribute kind, type and attribute name.
  /// Separate groups of more than two properties and computed properties longer than three lines.
  case propertyGrouping = "property_grouping"

  /// Separate local declarations, checks and final exits with one blank line between groups.
  /// Keep compact checks together. Permit zero or one blank line next to a multiline check.
  case statementGrouping = "statement_grouping"

  /// Use a switch for each if condition that projects or tests a SwiftSyntax node type.
  /// Include single checks, wrapper calls and extra conditions. Preserve evaluation order.
  case preferSyntaxKindSwitch = "prefer_syntax_kind_switch"

  /// Use a switch for each if condition with a native as? or is check, including negated checks.
  /// Keep calls, property reads and extra conditions in their original evaluation order.
  case preferTypeSwitch = "prefer_type_switch"

  /// Keep an operand and its member access together after an arithmetic, logical or comparison operator.
  case binaryOperandMemberWrap = "binary_operand_member_wrap"

  /// Permit a single-line if body only for one return, throw, break or continue statement. Put other statements
  /// in a multiline block.
  case singleLineIfExit = "single_line_if_exit"

  /// Permit a single-line else body, including guard else, only for one return, throw, break or continue
  /// statement.
  case singleLineElseExit = "single_line_else_exit"

  /// Keep a comparison operator with its right operand when the expression wraps.
  case comparisonOperatorNewline = "comparison_operator_newline"

  /// Keep self and the following member on the same line.
  case selfMemberNewline = "self_member_newline"

  /// Require a blank line after a single-line else block before the next statement. The enclosing closing brace
  /// needs no blank line.
  case compactElseBlankLine = "compact_else_blank_line"

  /// Start the assigned expression on the same line as =.
  case assignmentRhsSameLine = "assignment_rhs_same_line"

  /// Keep an inline body on one line, or start the body on the next line. Check functions, properties and
  /// closures. Skip closure headers and comments after {.
  case multilineInlineBlock = "multiline_inline_block"

  /// Put guard and each condition on separate lines when the header exceeds 120 characters. Exclude else from the
  /// length and count each wrapped gap as one space. Short headers can wrap freely. Review headers with comments
  /// manually.
  case multilineGuardConditions = "multiline_guard_conditions"

  /// Keep one simple return, throw, break or continue with else when the line fits within 120 characters. Count
  /// the body indent as two spaces after SwiftFormat. Keep complex bodies multiline.
  case compactGuardExit = "compact_guard_exit"

  /// Keep a *, / and % chain on one line, or put each operand on its own line. Use leading operators.
  case mixedMultiplicativeExpressionWrap = "mixed_multiplicative_expression_wrap"

  /// Keep generic, tuple, array and dictionary return types on one line after ->. Wrap function parameters
  /// instead. Check the return-type syntax node.
  case multilineReturnType = "multiline_return_type"

  /// Keep a qualified return type together across member access. Check nested generic arguments recursively.
  case splitReturnTypeMember = "split_return_type_member"

  /// Keep && and || operands on one line, or put each continuation on a separate line. Check parenthesized groups
  /// separately.
  case mixedBooleanConditionWrap = "mixed_boolean_condition_wrap"

  /// After two or more members on one line, put each further member on a new line. The base can include one
  /// property, such as model.state. Check subscripts, generic calls, optional chaining and closures.
  case mixedMemberChainWrap = "mixed_member_chain_wrap"

  /// Start a call after a previous call on a new line if its arguments wrap after (. Check generic arguments,
  /// optional chaining and closures.
  case chainedCallArgumentsWrap = "chained_call_arguments_wrap"

  /// Start a call with a multiline closure on a new line after the previous closure.
  case chainedClosureNewline = "chained_closure_newline"

  /// Use a single-line string literal for interpolated text with one physical content line. Skip raw literals and
  /// literals with newline, carriage-return or Unicode escapes.
  case singleLineInterpolatedString = "single_line_interpolated_string"

  /// Keep ?? with its fallback, and keep the fallback member chain together. Wrap before ?? when necessary.
  /// SwiftFormat does not select this break automatically.
  case nilCoalescingMemberWrap = "nil_coalescing_member_wrap"

  /// Declare file-level functions, including functions in #if blocks, in a type or extension. Permit global
  /// debugFatalError overloads. Identify methods and local functions by their parent syntax nodes.
  case noGlobalFunctions = "no_global_functions"

  /// Start enum case declarations on a new line after {. Permit multiple values separated by commas in one
  /// declaration.
  case enumCaseNewline = "enum_case_newline"

  /// Keep single-line enum case declarations together. Use one blank line if either declaration spans multiple lines.
  /// Count attached comments as part of each declaration. Put separation before leading comments.
  case enumCaseBlankLine = "enum_case_blank_line"

  /// Keep member access within an arithmetic operand together, such as components.blue or measure(...).height.
  case arithmeticMemberWrap = "arithmetic_member_wrap"

  /// Move the first ?? and its fallback to a new line when the source line exceeds 120 characters. Include any
  /// preceding string literal in the length.
  case longNilCoalescing = "long_nil_coalescing"

  /// Combine adjacent string literals into one. Use a multiline literal with line continuations for long text.
  case concatenatedStringLiterals = "concatenated_string_literals"

  /// Keep as, as? and as! on the expression line or with its closing parenthesis. SwiftLint checks the ban on as!
  /// separately.
  case castOperatorNewline = "cast_operator_newline"

  /// Keep -> after the closing parameter parenthesis. Wrap long declarations inside the parameter list.
  case returnArrowNewline = "return_arrow_newline"

  /// Keep a + and - chain on one line, or put each operand on its own line. Use leading operators.
  /// Check parenthesized groups separately.
  case mixedAdditiveExpressionWrap = "mixed_additive_expression_wrap"

  /// Put a wrapped +, -, *, / or % at the start of the continuation with its right operand.
  case arithmeticOperatorEndOfLine = "arithmetic_operator_end_of_line"

  /// Keep short single-argument calls with name, member or arithmetic arguments together as left operands.
  /// Check calls that fit within 120 characters after joining their lines.
  case arithmeticCallArgumentsWrap = "arithmetic_call_arguments_wrap"

  /// Keep arithmetic on one line when the full source line fits within 120 characters. Otherwise, prefer
  /// breaks in the outer expression before call arguments or parenthesized groups. At the same nesting level,
  /// wrap + or - before *, / or %. Split a nested group only when its segment still exceeds the limit.
  /// Indent continuations two spaces.
  /// Skip comments, multiline tokens and breaks outside arithmetic boundaries. Preserve all expression syntax.
  case arithmeticPrecedenceWrap = "arithmetic_precedence_wrap"

  /// Put each wrapped binary operator with its right operand, including custom operators.
  /// Standard assignment operators use assignment layout. Check operations in their right operands separately.
  /// Unary operators are separate syntax nodes and do not enter this check.
  case binaryOperatorWrap = "binary_operator_wrap"

  /// After multiline call arguments, tuples, subscript arguments or collection elements, put the closing
  /// parenthesis or bracket on a separate line. Nested closing delimiters can share that line.
  /// An outer operator can follow the delimiter on the same line. A nested closing delimiter or multiline
  /// string closing quote can start a compact tail with arguments, casts, member access or calls.
  /// Arithmetic and ternary expressions still require their own closing line.
  case multilineExpressionClosingDelimiter = "multiline_expression_closing_delimiter"
}

extension StyleRule {

  var message: String {
    switch self {
    case .mixedNilCoalescingWrap: "Put ?? operands on one line or each continuation on its own line."
    case .ifExpressionBindingSameLine: "Keep let or var and the if expression binding on the same line."

    case .ifExpressionConditionIndent:
      """
      Indent each continued if expression condition by two spaces from the \
      declaration.
      """

    case .multilineIfBrace:
      """
      Put the opening brace on its own line after wrapped conditions; argument \
      wrapping does not count.
      """

    case .ifArgumentBraceNewline: "Keep the opening brace with the condition when only call arguments wrap."
    case .mixedIfConditions: "Put if conditions on one line or each condition on its own line."
    case .collapsibleNestedIf: "Combine these nested if conditions in their current evaluation order."
    case .switchCaseSpacing: "Keep compact switch cases together; separate multiline cases with one blank line."
    case .memberSpacing: "Separate type openings, member kinds and multiline members with one blank line."
    case .propertyGrouping: "Group properties by visibility, kind, type and attribute; use the required blank lines."
    case .statementGrouping: "Separate statement groups; allow at most one blank line next to multiline checks."
    case .preferTypeSwitch: "Use a switch for this as? or is condition."
    case .preferSyntaxKindSwitch: "Use a syntax-kind switch for this type check."

    case .binaryOperandMemberWrap:
      """
      Keep a member access with its operand; wrap between operands or within \
      call arguments.
      """

    case .singleLineIfExit: "Use a single-line if body only for return, throw, break or continue."
    case .singleLineElseExit: "Use a single-line else body only for return, throw, break or continue."
    case .comparisonOperatorNewline: "Keep the comparison operator with its right operand on the continuation line."
    case .selfMemberNewline: "Keep self and its member on the same line."
    case .compactElseBlankLine: "Add a blank line after a compact else block before the next statement."
    case .assignmentRhsSameLine: "Start the assigned expression on the same line as =."
    case .multilineInlineBlock: "Keep an inline block on one line, or start its body on the next line."

    case .multilineGuardConditions:
      """
      When a guard header exceeds 120 characters, put guard and each condition \
      on separate lines.
      """

    case .compactGuardExit:
      """
      Put a single return, throw, break or continue on the else line when it \
      fits within 120 characters.
      """

    case .mixedMultiplicativeExpressionWrap:
      """
      Put product operands on one line or one per line; use leading operators.
      """

    case .multilineReturnType: "Keep the return type on one line; wrap function parameters instead."
    case .splitReturnTypeMember: "Keep qualified return type names on one line."
    case .mixedBooleanConditionWrap: "Put boolean operands on one line or each continuation on its own line."

    case .mixedMemberChainWrap:
      """
      Put each continuation on a new line; the base may include one property, \
      such as model.state.
      """

    case .chainedCallArgumentsWrap: "Start a chained call on a new line before wrapping its arguments."
    case .chainedClosureNewline: "Start a chained call with a multiline closure on a new line."
    case .singleLineInterpolatedString: "Use a single-line literal when interpolated text has one content line."
    case .nilCoalescingMemberWrap: "Keep ?? and the fallback together; wrap before ??."
    case .noGlobalFunctions: "Declare the function in its owning type or extension; debugFatalError may be global."
    case .enumCaseNewline: "Start enum cases on a new line after the opening brace."
    case .enumCaseBlankLine: "Keep compact enum cases together; separate multiline cases with one blank line."
    case .arithmeticMemberWrap: "Keep member access within an operand; split additive terms between lines."
    case .longNilCoalescing: "Move ?? and the fallback to the next line when the line exceeds 120 characters."

    case .concatenatedStringLiterals:
      """
      Use one string literal; wrap long text with triple quotes and line \
      continuations.
      """

    case .castOperatorNewline: "Keep as, as? and as! with the expression being cast."
    case .returnArrowNewline: "Keep the return arrow and type with the closing parenthesis; wrap parameters instead."

    case .mixedAdditiveExpressionWrap:
      "Put additive terms on one line or one per line; use leading operators."

    case .arithmeticOperatorEndOfLine: "Move the arithmetic operator to the continuation with its right operand."

    case .arithmeticPrecedenceWrap:
      "Keep short arithmetic on one line; wrap outer operations before nested groups, with + or - before *, / or %."

    case .binaryOperatorWrap: "Put the binary operator with its right operand on the continuation line."
    case .multilineExpressionClosingDelimiter: "Put the closing delimiter on a separate line after multiline content."
    case .arithmeticCallArgumentsWrap: "Keep a short single-argument call whole before the outer operator."
    }
  }
}
