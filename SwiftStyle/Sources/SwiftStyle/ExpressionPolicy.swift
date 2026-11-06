import SwiftSyntax

/// Checks expression structure for the complex_control_flow_condition rule, independent of API names.
///
/// Permit subscripts, properties, API result comparisons, ranges, key paths and output arguments.
/// Permit nested argument calls whose compact text is at most 120 characters. Check their contents recursively.
/// Permit one arithmetic operation per operand. Require named values for multiple operations.
/// The compiler and code review check names, types, side effects and conditional evaluation.
///
/// ConditionExtractionFormatter can name the first Boolean condition of a standalone if or guard.
/// Other conditions keep their diagnostics for an owner to review their evaluation order and scope.
enum ExpressionPolicy {

  private static let logical = Set(["&&", "||"])
  private static let arithmetic = Set(["+", "-", "*", "/", "%"])
  private static let comparisons = Set(["==", "!=", "<", ">", "<=", ">=", "~="])

  static func isComplex(_ expression: ExprSyntax) -> Bool {
    if arithmeticCount(expression) > 1 { return true }

    switch (Syntax(expression).as(SyntaxEnum.self)) {
    case .infixOperatorExpr(let operation) where (comparisons.contains(operation.operator.trimmedDescription)):
      return !isSimpleComparedValue(operation.leftOperand) || !isSimpleComparedValue(operation.rightOperand)
    default:
      break
    }

    switch expression.as(ExprSyntaxEnum.self) {
    case .functionCallExpr(let call): return isComplexCall(call)
    case .closureExpr(let closure): return !isSimpleClosure(closure)

    default:
      return expression.children(viewMode: .sourceAccurate).contains { child in
        if let nested = child.as(ExprSyntax.self) { return isComplex(nested) }
        return containsComplexExpression(child)
      }
    }
  }

  /// Checks arithmetic in a binding that already gives the returned value a name.
  static func bindingIsComplex(_ expression: ExprSyntax) -> Bool {
    if arithmeticCount(expression) > 1 { return true }
    return expression.children(viewMode: .sourceAccurate).contains { bindingIsComplex($0) }
  }

  private static func bindingIsComplex(_ node: Syntax) -> Bool {
    if let expression = node.as(ExprSyntax.self) { return bindingIsComplex(expression) }
    return node.children(viewMode: .sourceAccurate).contains { bindingIsComplex($0) }
  }

  private static func containsComplexExpression(_ node: Syntax) -> Bool {
    if let expression = node.as(ExprSyntax.self) { return isComplex(expression) }
    return node.children(viewMode: .sourceAccurate).contains { containsComplexExpression($0) }
  }

  private static func unwrapped(_ expression: ExprSyntax) -> ExprSyntax {
    switch (Syntax(expression).as(SyntaxEnum.self)) {
    case .tupleExpr(let tuple):
      if tuple.elements.count == 1, let element = tuple.elements.first, element.label == nil {return unwrapped(
        element.expression
      )
    }

    default:
      break
    }

    return switch expression.as(ExprSyntaxEnum.self) {
    case .prefixOperatorExpr(let prefix): unwrapped(prefix.expression)
    case .optionalChainingExpr(let optional): unwrapped(optional.expression)
    case .tryExpr(let attempt): unwrapped(attempt.expression)
    case .awaitExpr(let awaited): unwrapped(awaited.expression)
    default: expression
    }
  }

  /// Counts operations through parentheses, result properties and conversions such as Double(...).
  private static func arithmeticCount(_ expression: ExprSyntax) -> Int {
    let value = unwrapped(expression)
    switch (Syntax(value).as(SyntaxEnum.self)) {
    case .infixOperatorExpr(let operation):
      let name = operation.operator.trimmedDescription
      guard arithmetic.contains(name) else { return 0 }
      return 1 + arithmeticCount(operation.leftOperand) + arithmeticCount(operation.rightOperand)

    default:
      break
    }
    switch (Syntax(value).as(SyntaxEnum.self)) {
    case .memberAccessExpr(let member):
      if let base = member.base {return arithmeticCount(base)
    }

    default:
      break
    }
    switch (Syntax(value).as(SyntaxEnum.self)) {
    case .functionCallExpr(let call):
      if isConstructor(call), call.arguments.count == 1, let argument = call.arguments.first {return arithmeticCount(
        argument.expression
      )
    }

    default:
      break
    }

    return 0
  }

  private static func isComplexCall(_ call: FunctionCallExprSyntax) -> Bool {
    let closures = call.arguments.compactMap { $0.expression.as(ClosureExprSyntax.self) }
      + [call.trailingClosure].compactMap { $0 }
      + call.additionalTrailingClosures.map(\.closure)
    guard closures.allSatisfy(isSimpleClosure) else { return true }
    let permitsPipeline = !closures.isEmpty
    guard isSimpleReceiver(call.calledExpression, permitsPipeline: permitsPipeline) else { return true }

    let hasOutputArgument = call.arguments.contains { $0.expression.is(InOutExprSyntax.self) }
    return call.arguments.contains { argument in
      switch (Syntax(argument.expression).as(SyntaxEnum.self)) {
      case .closureExpr:
        return false
      default:
        break
      }

      return !isSimpleArgument(argument.expression, permitsEmptyCall: hasOutputArgument)
    }
  }

  private static func isSimpleReceiver(_ expression: ExprSyntax, permitsPipeline: Bool) -> Bool {
    let value = unwrapped(expression)
    switch value.as(ExprSyntaxEnum.self) {
    case .genericSpecializationExpr(let specialization):
      return isSimpleReceiver(specialization.expression, permitsPipeline: permitsPipeline)

    case .memberAccessExpr(let member):
      guard let base = member.base else { return true }
      let receiver = unwrapped(base)
      switch (Syntax(receiver).as(SyntaxEnum.self)) {
      case .functionCallExpr(let call):
        let permitsCall = isConstructor(call) || permitsPipeline
        return permitsCall && !isComplexCall(call)

      default:
        break
      }
      return isSimpleReceiver(receiver, permitsPipeline: permitsPipeline)

    case .subscriptCallExpr(let subscriptCall):
      return isSimpleReceiver(subscriptCall.calledExpression, permitsPipeline: permitsPipeline)
        && subscriptCall.arguments.allSatisfy { isSimpleArgument($0.expression) }

    case .functionCallExpr(let call):
      return isConstructor(call) && !isComplexCall(call)

    default: return isSimpleArgument(value)
    }
  }

  /// Permits short nested calls, constructors and empty calls for output arguments: api(currentID(), &output).
  private static func isSimpleArgument(_ expression: ExprSyntax, permitsEmptyCall: Bool = false) -> Bool {
    let value = unwrapped(expression)
    if arithmeticCount(value) > 1 { return false }
    switch value.as(ExprSyntaxEnum.self) {
    case .functionCallExpr(let call):
      let permitsCall = isConstructor(call) || SourceLayout.compact(call.trimmedDescription).count <= 120
        || (permitsEmptyCall && call.arguments.isEmpty)
      return permitsCall && !isComplexCall(call)

    case .closureExpr(let closure): return isSimpleClosure(closure)
    case .ifExpr, .switchExpr: return false

    default:
      return value.children(viewMode: .sourceAccurate).allSatisfy { child in
        simpleArgumentChild(child, permitsEmptyCall: permitsEmptyCall)
      }
    }
  }

  private static func simpleArgumentChild(_ node: Syntax, permitsEmptyCall: Bool) -> Bool {
    if let expression = node.as(ExprSyntax.self) {
      return isSimpleArgument(expression, permitsEmptyCall: permitsEmptyCall)
    }

    return node.children(viewMode: .sourceAccurate).allSatisfy {
      simpleArgumentChild($0, permitsEmptyCall: permitsEmptyCall)
    }
  }

  private static func isSimpleComparedValue(_ expression: ExprSyntax) -> Bool {
    let value = unwrapped(expression)
    if arithmeticCount(value) > 1 { return false }
    switch (Syntax(value).as(SyntaxEnum.self)) {
    case .infixOperatorExpr(let operation) where (arithmetic.contains(operation.operator.trimmedDescription)):
      return isSimpleComparedValue(operation.leftOperand) && isSimpleComparedValue(operation.rightOperand)
    default:
      break
    }
    switch (Syntax(value).as(SyntaxEnum.self)) {
    case .functionCallExpr(let call):
      guard isSimpleReceiver(call.calledExpression, permitsPipeline: false) else { return false }

      let hasOutputArgument = call.arguments.contains { $0.expression.is(InOutExprSyntax.self) }
      return call.arguments.allSatisfy { argument in
        if arithmeticCount(argument.expression) == 1 { return isSimpleComparedValue(argument.expression) }
        return isSimpleArgument(argument.expression, permitsEmptyCall: hasOutputArgument)
      } && call.trailingClosure == nil && call.additionalTrailingClosures.isEmpty

    default:
      break
    }
    switch (Syntax(value).as(SyntaxEnum.self)) {
    case .memberAccessExpr(let member):
      if let base = member.base {return isSimpleComparedValue(base)
    }

    default:
      break
    }
    switch (Syntax(value).as(SyntaxEnum.self)) {
    case .subscriptCallExpr(let subscriptCall):
      return isSimpleComparedValue(subscriptCall.calledExpression)
        && subscriptCall.arguments.allSatisfy { isSimpleArgument($0.expression) }

    default:
      break
    }
    return isSimpleArgument(value)
  }

  /// Treats an uppercase name or an implicit .init/.case call as a constructor.
  /// The compiler and code review check the name's actual meaning.
  private static func isConstructor(_ call: FunctionCallExprSyntax) -> Bool {
    let callee = unwrapped(call.calledExpression)
    return switch callee.as(ExprSyntaxEnum.self) {
    case .genericSpecializationExpr(let specialization):
      startsWithUppercase(specialization.expression.trimmedDescription)

    case .memberAccessExpr(let member): member.base == nil || startsWithUppercase(member.declName.baseName.text)
    case .declReferenceExpr(let reference): startsWithUppercase(reference.baseName.text)
    default: callee.is(ArrayExprSyntax.self) || callee.is(DictionaryExprSyntax.self)
    }
  }

  private static func startsWithUppercase(_ name: String) -> Bool {
    guard let first = name.first else { return false }
    return first.isUppercase
  }

  /// Accepts one expression or return: a simple call or up to two predicates joined by &&.
  /// Long nested argument calls, nested closures and multiple statements require a named value.
  /// Each predicate can compare two values with one arithmetic operation per operand.
  private static func isSimpleClosure(_ closure: ClosureExprSyntax) -> Bool {
    guard closure.statements.count == 1, let statement = closure.statements.first else { return false }
    let expression: ExprSyntax? = switch (Syntax(statement.item).as(SyntaxEnum.self)) {
    case .returnStmt(let returned):
      returned.expression
    default:
      switch (Syntax(statement.item).as(SyntaxEnum.self)) {
      case .expressionStmt(let expressionStatement):
        expressionStatement.expression
      default:
        statement.item.as(ExprSyntax.self)
      }
    }
    guard let expression else { return false }
    let value = unwrapped(expression)
    switch (Syntax(value).as(SyntaxEnum.self)) {
    case .functionCallExpr(let call):
      let hasNestedClosure = call.trailingClosure != nil
        || !call.additionalTrailingClosures.isEmpty
        || call.arguments.contains { $0.expression.is(ClosureExprSyntax.self) }
      return !hasNestedClosure && !isComplexCall(call)

    default:
      break
    }
    return predicateParts(value).map { parts in
      parts.count <= 2 && parts.allSatisfy { !isComplex($0) }
    } ?? false
  }

  private static func predicateParts(_ expression: ExprSyntax) -> [ExprSyntax]? {
    let value = unwrapped(expression)
    guard let operation = value.as(InfixOperatorExprSyntax.self) else { return [value] }
    let name = operation.operator.trimmedDescription
    guard logical.contains(name) else { return [value] }
    guard
      name == "&&",
      let left = predicateParts(operation.leftOperand),
      let right = predicateParts(operation.rightOperand)
    else { return nil }
    return left + right
  }
}
