import SwiftSyntax

/// Describes one property declaration without changing its initializer or resolving external types.
struct PropertyLayout {
  let declaration: VariableDeclSyntax
  let visibility: Int
  let kind: Int
  let type: String?
  let annotations: [String]

  init(_ declaration: VariableDeclSyntax) {
    self.declaration = declaration
    visibility = Self.visibility(of: declaration)
    let names = declaration.attributes.compactMap { element in
      element.as(AttributeSyntax.self)?.attributeName.trimmedDescription
    }
    annotations = names.sorted()
    if declaration.modifiers.contains(where: { $0.name.text == "static" || $0.name.text == "class" }) {
      kind = 0
    } else if !annotations.isEmpty {
      kind = 3
    } else {
      kind = declaration.bindingSpecifier.text == "let" ? 1 : 2
    }
    var types: [String?] = []
    var followingType: String?
    for binding in declaration.bindings.reversed() {
      if let annotation = binding.typeAnnotation {
        followingType = Self.typeName(annotation.type)
        types.append(followingType)
      } else if let initializer = binding.initializer {
        followingType = nil
        types.append(annotations.isEmpty ? Self.inferredType(initializer.value) : nil)
      } else {
        types.append(followingType)
      }
    }
    type = types.first.flatMap { first in
      first.flatMap { name in types.allSatisfy { $0 == name } ? name : nil }
    }
  }

  var groups: [[String]] {
    let prefix = [String(visibility), String(kind)]
    let typeKey = type ?? "unknown:\(declaration.position.utf8Offset)"
    return [Array(prefix.prefix(1)), prefix, prefix + [typeKey], prefix + [typeKey] + annotations]
  }

  var elementCount: Int { declaration.bindings.count }

  func hasLongAccessor(in layout: SourceLayout) -> Bool {
    declaration.bindings.contains { binding in
      guard let accessors = binding.accessorBlock else { return false }

      let computed: Bool = switch accessors.accessors {
      case .getter: true

      case .accessors(let list):
        list.contains { ["get", "set", "_read", "_modify"].contains($0.accessorSpecifier.text) }

      @unknown default: false
      }
      return computed && layout.endLine(declaration) - layout.line(declaration) + 1 > 3
    }
  }

  private static func visibility(of declaration: VariableDeclSyntax) -> Int {
    if let explicit = visibility(in: declaration.modifiers) { return explicit }

    var ancestor = declaration.parent
    while let node = ancestor {
      if let declaration = node.as(DeclSyntax.self) {
        switch declaration.as(DeclSyntaxEnum.self) {
        case .extensionDecl(let owner): return visibility(in: owner.modifiers) ?? 2
        case .protocolDecl(let owner): return visibility(in: owner.modifiers) ?? 2
        case .structDecl, .classDecl, .actorDecl, .enumDecl: return 2
        default: break
        }
      }
      ancestor = node.parent
    }
    return 2
  }

  private static func visibility(in modifiers: DeclModifierListSyntax) -> Int? {
    let names = ["open", "public", "internal", "private", "fileprivate"]
    return modifiers.first(where: { $0.detail == nil && names.contains($0.name.text) })
      .flatMap { names.firstIndex(of: $0.name.text) }
  }

  /// Uses literals and direct constructor names for properties without attributes.
  /// Attributes can change the result type through a property wrapper. Unknown result types are not compared.
  private static func inferredType(_ expression: ExprSyntax) -> String? {
    switch expression.as(ExprSyntaxEnum.self) {
    case .integerLiteralExpr: "Int"
    case .floatLiteralExpr: "Double"
    case .booleanLiteralExpr: "Bool"
    case .stringLiteralExpr: "String"

    case .prefixOperatorExpr(let prefix):
      ["+", "-"].contains(prefix.operator.text) ? inferredType(prefix.expression) : nil

    case .functionCallExpr(let call): constructorType(call.calledExpression)
    default: nil
    }
  }

  private static func constructorType(_ expression: ExprSyntax) -> String? {
    let name: String
    switch expression.as(ExprSyntaxEnum.self) {
    case .declReferenceExpr(let reference): name = reference.baseName.text
    case .memberAccessExpr(let member): name = member.declName.baseName.text

    case .genericSpecializationExpr(let specialization):
      return constructorType(specialization.expression).map { _ in
        expression.tokens(viewMode: .sourceAccurate).map(\.text).joined()
      }

    default: return nil
    }
    guard name.first?.isUppercase == true else { return nil }

    return expression.tokens(viewMode: .sourceAccurate).map(\.text).joined()
  }

  private static func typeName(_ type: TypeSyntax) -> String {
    switch type.as(TypeSyntaxEnum.self) {
    case .optionalType(let optional): "Optional<\(typeName(optional.wrappedType))>"
    case .arrayType(let array): "Array<\(typeName(array.element))>"
    case .dictionaryType(let dictionary): "Dictionary<\(typeName(dictionary.key)),\(typeName(dictionary.value))>"
    default: type.tokens(viewMode: .sourceAccurate).map(\.text).joined()
    }
  }
}
