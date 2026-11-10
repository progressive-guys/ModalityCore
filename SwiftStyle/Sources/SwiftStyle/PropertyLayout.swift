import SwiftSyntax

/// Describes one property declaration without changing its initializer or resolving external types.
struct PropertyLayout {

  enum Storage {

    case scalar
    case function
    case otherValue
    case unknown
  }

  let kind: Int
  let type: String?
  let visibility: Int
  let setterVisibility: Int
  let annotations: [String]
  let declaration: VariableDeclSyntax

  init(_ declaration: VariableDeclSyntax) {
    self.declaration = declaration
    visibility = Self.visibility(of: declaration)
    setterVisibility = Self.visibility(in: declaration.modifiers, setter: true) ?? visibility

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

  /// Counts each level of the property hierarchy, including groups with different data types.
  var groups: [[String]] {
    let access = [String(visibility), String(setterVisibility)]
    let kindGroup = access + [String(kind)]
    let attributeGroup = kindGroup + ["attributes"] + annotations
    let typeGroups = type.map { [attributeGroup + ["type", $0]] } ?? []
    return [[String(visibility)], access, kindGroup, attributeGroup] + typeGroups
  }

  /// Observers keep a stored value. Getter and setter accessors describe a computed property.
  var isStored: Bool {
    declaration.bindings.allSatisfy { binding in
      guard let block = binding.accessorBlock else { return true }
      switch block.accessors {
      case .getter: return false
      case .accessors(let list):
        return !list.contains { ["get", "set", "_read", "_modify"].contains($0.accessorSpecifier.text) }
      @unknown default: return false
      }
    }
  }

  var elementCount: Int { declaration.bindings.count }

  /// Uses the longest declaration line, without its leading indentation.
  var lineLength: Int { SourceLayout.lineLength(declaration) }

  /// Wrappers and initializers can run user code. Plain Swift literals have no side effects.
  var evaluatesInitializer: Bool {
    !declaration.attributes.isEmpty || declaration.bindings.contains { binding in
      guard let value = binding.initializer?.value else { return false }
      return !Self.isStandardLiteral(value, type: binding.typeAnnotation?.type)
    }
  }

  /// Destruction follows stored-property order. A closure or an opaque value can own an object.
  var requiresStorageOrder: Bool {
    let sharedType = type == nil ? nil : declaration.bindings.last?.typeAnnotation?.type
    return evaluatesInitializer || declaration.bindings.contains {
      Self.storage(of: $0.typeAnnotation?.type ?? sharedType) != .scalar
    }
  }

  /// A change in read or write access starts a new group.
  func separatesAccess(from other: Self) -> Bool {
    visibility != other.visibility || setterVisibility != other.setterVisibility
  }

  /// Resolves syntax that determines both object lifetime and the escaping convention of a parameter.
  /// An unresolved type alias can name a function, even when its declaration is in another file.
  static func storage(of type: TypeSyntax?) -> Storage {
    guard let type else { return .unknown }

    let name: String

    switch type.as(TypeSyntaxEnum.self) {
    case .attributedType(let attributed): return storage(of: attributed.baseType)
    case .functionType: return .function
    case .tupleType(let tuple):
      if tuple.elements.count == 1, let element = tuple.elements.first { return storage(of: element.type) }
      return tuple.elements.allSatisfy { storage(of: $0.type) == .scalar } ? .scalar : .otherValue

    case .optionalType(let optional): return storage(of: optional.wrappedType) == .scalar ? .scalar : .otherValue
    case .arrayType, .dictionaryType: return .otherValue
    case .metatypeType: return .scalar
    case .identifierType(let identifier): name = identifier.name.text
    case .memberType(let member) where member.baseType.trimmedDescription == "Swift": name = member.name.text
    default: return .unknown
    }

    switch name {
    case "Bool", "String", "Character", "Int", "Int8", "Int16", "Int32", "Int64", "UInt", "UInt8", "UInt16",
      "UInt32", "UInt64", "Float", "Double", "Void", "Never": return .scalar
    case "Optional", "Array", "Dictionary", "Set", "Result": return .otherValue
    default: return .unknown
    }
  }

  /// A literal in a user-defined type can call its ExpressibleBy... initializer.
  /// Explicit scalar types use the Swift module name to rule out local types with the same name.
  private static func isStandardLiteral(_ value: ExprSyntax, type: TypeSyntax?) -> Bool {
    let isSwiftScalar = type?.as(MemberTypeSyntax.self)?.baseType.trimmedDescription == "Swift"
      && storage(of: type) == .scalar

    switch value.as(ExprSyntaxEnum.self) {
    case .integerLiteralExpr, .floatLiteralExpr, .booleanLiteralExpr: return isSwiftScalar
    case .stringLiteralExpr(let literal):
      return isSwiftScalar && literal.segments.allSatisfy { $0.is(StringSegmentSyntax.self) }
    case .arrayExpr(let array):
      return array.elements.isEmpty && type?.is(ArrayTypeSyntax.self) == true
    case .dictionaryExpr(let dictionary):
      return dictionary.content.is(TokenSyntax.self) && type?.is(DictionaryTypeSyntax.self) == true
    case .nilLiteralExpr: return type?.is(OptionalTypeSyntax.self) == true
    default: return false
    }
  }

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
    visibility(in: declaration.modifiers, parent: declaration.parent)
  }

  /// Uses read access and inherits the access of protocols and extensions.
  static func visibility(in modifiers: DeclModifierListSyntax, parent: Syntax?) -> Int {
    if let explicit = visibility(in: modifiers) { return explicit }

    var ancestor = parent
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

  private static func visibility(in modifiers: DeclModifierListSyntax, setter: Bool = false) -> Int? {
    let names = ["open", "public", "internal", "private", "fileprivate"]
    return modifiers.first(where: {
      (setter ? $0.detail?.detail.text == "set" : $0.detail == nil) && names.contains($0.name.text)
    })
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
