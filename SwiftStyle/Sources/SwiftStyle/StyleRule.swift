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

  /// Keep an operand and its member access together after an arithmetic, logical or comparison operator.
  case binaryOperandMemberWrap = "binary_operand_member_wrap"

  /// Permit a single-line if body only for one return, throw, break or continue statement. Put other statements
  /// in a multiline block.
  case singleLineIfExit = "single_line_if_exit"

  /// Permit a single-line else body, including guard else, only for one return, throw, break or continue
  /// statement.
  case singleLineElseExit = "single_line_else_exit"

  /// Keep a comparison operator with its left operand. Wrap long calls inside their argument lists.
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

  /// Keep product, division or remainder operands on one line, or put each continuation on a new line with a
  /// leading *, / or %.
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

  /// Separate adjacent enum case declarations with a blank line before the next case comment. Keep
  /// comma-separated values in one declaration together.
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

  /// Keep additive operands on one line, or put each continuation on a new line with a leading + or -. Check
  /// nested groups separately.
  case mixedAdditiveExpressionWrap = "mixed_additive_expression_wrap"

  /// Put a wrapped +, -, *, / or % on the next line with the following operand.
  case arithmeticOperatorEndOfLine = "arithmetic_operator_end_of_line"

  /// Keep short single-argument calls with name or member arguments together inside arithmetic. Wrap the outer
  /// expression first. Check calls that fit within 120 characters after joining their lines.
  case arithmeticCallArgumentsWrap = "arithmetic_call_arguments_wrap"
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

    case .binaryOperandMemberWrap:
      """
      Keep a member access with its operand; wrap between operands or within \
      call arguments.
      """

    case .singleLineIfExit: "Use a single-line if body only for return, throw, break or continue."

    case .singleLineElseExit: "Use a single-line else body only for return, throw, break or continue."

    case .comparisonOperatorNewline: "Keep a comparison operator with its left operand; wrap call arguments instead."

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
      Put product operands on one line or each continuation on its own line with \
      a leading operator.
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

    case .enumCaseBlankLine: "Add a blank line between enum case declarations, before the next case's comment."

    case .arithmeticMemberWrap: "Keep member access within an operand; split additive terms between lines."

    case .longNilCoalescing: "Move ?? and the fallback to the next line when the line exceeds 120 characters."

    case .concatenatedStringLiterals:
      """
      Use one string literal; wrap long text with triple quotes and line \
      continuations.
      """

    case .castOperatorNewline: "Keep as, as? and as! with the expression being cast."

    case .returnArrowNewline: "Keep the return arrow and type with the closing parenthesis; wrap parameters instead."

    case .mixedAdditiveExpressionWrap: "Put additive terms on one line or one term per line, with leading + or -."

    case .arithmeticOperatorEndOfLine: "Move the arithmetic operator to the next line with the following operand."

    case .arithmeticCallArgumentsWrap:
      """
      Wrap the outer arithmetic expression before splitting a short \
      single-argument call.
      """
    }
  }
}
