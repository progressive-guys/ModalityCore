import SwiftSyntax

/// Reads references that cross a statement boundary and names introduced in its scope.
/// Nested bindings hide outer names. Closure captures count as inputs to the closure.
struct StatementDependencies {

  let references: Set<String>
  let declarations: Set<String>
  let mutatedReference: String?
  let conditionReferences: Set<String>

  init(_ item: CodeBlockItemSyntax) {
    references = Self.references(in: Self.groupingInput(in: Syntax(item.item)), bound: [])
    declarations = Self.declarations(in: Syntax(item.item))
    mutatedReference = Self.mutatedReference(in: Syntax(item.item))
    conditionReferences = Self.conditionReferences(in: Syntax(item.item))
  }

  /// A standalone switch joins a preceding group through its subject.
  /// Expressions and closure captures use references from their complete value.
  private static func groupingInput(in node: Syntax) -> Syntax {
    switch node.as(SyntaxEnum.self) {
    case .expressionStmt(let statement): groupingInput(in: Syntax(statement.expression))
    case .switchExpr(let expression): Syntax(expression.subject)
    default: node
    }
  }

  /// Tracks the written variable or property path in a direct assignment statement.
  private static func mutatedReference(in node: Syntax) -> String? {
    switch node.as(SyntaxEnum.self) {
    case .expressionStmt(let statement): return mutatedReference(in: Syntax(statement.expression))
    case .infixOperatorExpr(let operation) where operation.isAssignmentOperation:
      return referencePath(operation.leftOperand)?.joined(separator: ".")

    default: return nil
    }
  }

  /// A mutation connects to a following check through its conditions.
  private static func conditionReferences(in node: Syntax) -> Set<String> {
    switch node.as(SyntaxEnum.self) {
    case .expressionStmt(let statement): conditionReferences(in: Syntax(statement.expression))
    case .ifExpr(let expression): conditions(expression.conditions, bound: []).references
    case .guardStmt(let statement): conditions(statement.conditions, bound: []).references
    default: []
    }
  }

  private static func references(in node: Syntax, bound: Set<String>) -> Set<String> {
    switch node.as(SyntaxEnum.self) {
    case .declReferenceExpr(let reference):
      let name = reference.baseName.text
      return bound.contains(name) ? [] : [name]

    case .memberAccessExpr(let member):
      var result = member.base.map { references(in: Syntax($0), bound: bound) } ?? []
      if let path = referencePath(ExprSyntax(member)), let root = path.first, !bound.contains(root) {
        result.insert(path.joined(separator: "."))
      }
      return result

    case .keyPathPropertyComponent:
      return []

    case .variableDecl(let declaration):
      var bound = bound
      var result: Set<String> = []
      for binding in declaration.bindings {
        if let initializer = binding.initializer {
          result.formUnion(references(in: Syntax(initializer.value), bound: bound))
        }

        bound.formUnion(names(in: Syntax(binding.pattern)))

        if let accessors = binding.accessorBlock {
          result.formUnion(references(in: Syntax(accessors), bound: bound))
        }
      }
      return result

    case .codeBlockItemList(let statements):
      var bound = bound
      var result: Set<String> = []
      for statement in statements {
        result.formUnion(references(in: Syntax(statement), bound: bound))
        bound.formUnion(declarations(in: Syntax(statement.item)))
      }
      return result

    case .ifExpr(let expression):
      let condition = conditions(expression.conditions, bound: bound)
      var result = condition.references.union(references(in: Syntax(expression.body), bound: condition.bound))
      if let alternative = expression.elseBody {
        result.formUnion(references(in: Syntax(alternative), bound: bound))
      }
      return result

    case .guardStmt(let statement):
      return conditions(statement.conditions, bound: bound).references
        .union(references(in: Syntax(statement.body), bound: bound))

    case .whileStmt(let statement):
      let condition = conditions(statement.conditions, bound: bound)
      return condition.references.union(references(in: Syntax(statement.body), bound: condition.bound))

    case .forStmt(let statement):
      let bodyBound = bound.union(names(in: Syntax(statement.pattern)))
      var result = references(in: Syntax(statement.sequence), bound: bound)
        .union(references(in: Syntax(statement.body), bound: bodyBound))
      if let clause = statement.whereClause {
        result.formUnion(references(in: Syntax(clause.condition), bound: bodyBound))
      }
      return result

    case .repeatStmt(let statement):
      let bodyNames = statement.body.statements.reduce(into: bound) {
        $0.formUnion(declarations(in: Syntax($1.item)))
      }
      return references(in: Syntax(statement.body), bound: bound)
        .union(references(in: Syntax(statement.condition), bound: bodyNames))

    case .closureExpr(let closure):
      var bodyBound = bound
      var result: Set<String> = []
      for capture in closure.signature?.capture?.items ?? [] {
        if let initializer = capture.initializer {
          result.formUnion(references(in: Syntax(initializer.value), bound: bound))
        } else if !bound.contains(capture.name.text) {
          result.insert(capture.name.text)
        }

        bodyBound.insert(capture.name.text)
      }

      switch closure.signature?.parameterClause {
      case .simpleInput(let parameters):
        bodyBound.formUnion(parameters.map { $0.name.text })

      case .parameterClause(let clause):
        bodyBound.formUnion(clause.parameters.map { ($0.secondName ?? $0.firstName).text })

      default: break
      }

      return result.union(references(in: Syntax(closure.statements), bound: bodyBound))

    case .switchCase(let branch):
      var branchBound = bound
      var result: Set<String> = []
      if case .case(let label) = branch.label {
        for item in label.caseItems {
          let itemBound = bound.union(names(in: Syntax(item.pattern)))
          result.formUnion(references(in: Syntax(item.pattern), bound: itemBound))
          if let clause = item.whereClause {
            result.formUnion(references(in: Syntax(clause.condition), bound: itemBound))
          }
          branchBound.formUnion(itemBound)
        }
      }
      return result.union(references(in: Syntax(branch.statements), bound: branchBound))

    case .catchClause(let clause):
      let catchNames: Set<String> = clause.catchItems.isEmpty ? ["error"] : names(in: Syntax(clause.catchItems))
      let catchBound = bound.union(catchNames)
      return references(in: Syntax(clause.catchItems), bound: catchBound)
        .union(references(in: Syntax(clause.body), bound: catchBound))

    case .functionDecl, .structDecl, .classDecl, .enumDecl, .actorDecl, .protocolDecl, .extensionDecl:
      return []

    default:
      return node.children(viewMode: .sourceAccurate).reduce(into: []) {
        $0.formUnion(references(in: $1, bound: bound))
      }
    }
  }

  /// A condition binding is visible to later conditions and the successful branch.
  private static func conditions(
    _ conditions: ConditionElementListSyntax,
    bound: Set<String>
  ) -> (references: Set<String>, bound: Set<String>) {
    var bound = bound
    var result: Set<String> = []
    for condition in conditions {
      switch condition.condition {
      case .optionalBinding(let binding):
        let introduced = names(in: Syntax(binding.pattern))
        if let initializer = binding.initializer {
          result.formUnion(references(in: Syntax(initializer.value), bound: bound))
        } else {
          result.formUnion(introduced.subtracting(bound))
        }
        bound.formUnion(introduced)

      case .matchingPattern(let binding):
        result.formUnion(references(in: Syntax(binding.pattern), bound: bound))
        result.formUnion(references(in: Syntax(binding.initializer.value), bound: bound))
        bound.formUnion(names(in: Syntax(binding.pattern)))

      default:
        result.formUnion(references(in: Syntax(condition), bound: bound))
      }
    }
    return (result, bound)
  }

  private static func declarations(in node: Syntax) -> Set<String> {
    switch node.as(SyntaxEnum.self) {
    case .variableDecl(let declaration):
      return declaration.bindings.reduce(into: []) { $0.formUnion(names(in: Syntax($1.pattern))) }

    case .guardStmt(let statement):
      return conditions(statement.conditions, bound: []).bound

    case .functionDecl(let declaration):
      return [declaration.name.text]

    default: return []
    }
  }

  private static func names(in pattern: Syntax) -> Set<String> {
    if let identifier = pattern.as(IdentifierPatternSyntax.self) { return [identifier.identifier.text] }

    return pattern.children(viewMode: .sourceAccurate).reduce(into: []) {
      $0.formUnion(names(in: $1))
    }
  }

  /// Keeps each property in the path so different fields of the same object stay distinct.
  private static func referencePath(_ expression: ExprSyntax) -> [String]? {
    switch expression.as(ExprSyntaxEnum.self) {
    case .declReferenceExpr(let reference): return [reference.baseName.text]
    case .memberAccessExpr(let member):
      guard let base = member.base, let path = referencePath(base) else { return nil }
      return path + [member.declName.baseName.text]

    case .optionalChainingExpr(let expression): return referencePath(expression.expression)
    default: return nil
    }
  }

}
