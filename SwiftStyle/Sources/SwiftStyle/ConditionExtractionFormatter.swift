import Foundation
import SwiftSyntax

/// Names a complete Boolean condition at the same point in the enclosing statement list.
/// Keeping the expression intact preserves argument order, short-circuit evaluation and type context.
final class ConditionExtractionFormatter: SyntaxVisitor {

  private let formatter: StructuralFormatter

  private var names: Set<String>

  init(formatter: StructuralFormatter, tree: Syntax) {
    self.formatter = formatter
    names = Set(tree.tokens(viewMode: .sourceAccurate).map { $0.text.replacingOccurrences(of: "`", with: "") })
    super.init(viewMode: .sourceAccurate)
  }

  override func visit(_ node: IfExprSyntax) -> SyntaxVisitorContinueKind {
    guard let item = standaloneItem(node),
          let statements = item.parent?.as(CodeBlockItemListSyntax.self),
          node.elseBody == nil || statements.count > 1
    else { return .visitChildren }
    return extract(node.conditions, before: item) ? .skipChildren : .visitChildren
  }

  override func visit(_ node: GuardStmtSyntax) -> SyntaxVisitorContinueKind {
    guard let item = standaloneItem(node) else { return .visitChildren }
    return extract(node.conditions, before: item) ? .skipChildren : .visitChildren
  }

  /// Finds a statement stored directly in a statement list.
  private func standaloneItem(_ node: some SyntaxProtocol) -> CodeBlockItemSyntax? {
    var parent = node.parent
    if parent?.is(ExpressionStmtSyntax.self) == true { parent = parent?.parent }
    return parent?.as(CodeBlockItemSyntax.self)
  }

  /// Only the first Boolean condition runs whenever the statement is reached.
  /// A single if/else can be an implicit result, so its owner must contain another statement.
  private func extract(_ conditions: ConditionElementListSyntax, before item: CodeBlockItemSyntax) -> Bool {
    guard let first = conditions.first,
          case .expression(let expression) = first.condition,
          ExpressionPolicy.isComplex(expression),
          !expression.tokens(viewMode: .sourceAccurate).contains(where: { $0.tokenKind == .pound })
    else { return false }

    let base = "matchesCondition"
    var name = base
    var suffix = 2
    while names.contains(name) {
      name = base + String(suffix)
      suffix += 1
    }
    names.insert(name)

    let start = item.positionAfterSkippingLeadingTrivia.utf8Offset
    let expressionStart = expression.positionAfterSkippingLeadingTrivia.utf8Offset
    let end = expression.endPositionBeforeTrailingTrivia.utf8Offset
    let header = String(decoding: Array(formatter.source.utf8)[start..<expressionStart], as: UTF8.self)
    let newline = formatter.source.contains("\r\n") ? "\r\n" : "\n"
    let indent = String(repeating: " ", count: formatter.layout.indent(item))

    let replacement = "let \(name): Swift.Bool = \(expression.trimmedDescription)"
      + newline
      + indent
      + header
      + name

    formatter.edits.append(SourceEdit(range: start..<end, replacement: replacement))

    return true
  }
}
