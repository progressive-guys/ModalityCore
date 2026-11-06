import SwiftSyntax

/// Makes instance properties of an explicitly declared SwiftUI View private, except body.
enum ViewPropertyAccess {

  static func owner(of node: some SyntaxProtocol) -> StructDeclSyntax? {
    var ancestor = node.parent
    while let current = ancestor {
      switch current.as(SyntaxEnum.self) {
      case .structDecl(let declaration):
        return isView(declaration) ? declaration : nil
      case .classDecl, .enumDecl, .actorDecl, .codeBlock, .closureExpr, .accessorBlock: return nil
      default: ancestor = current.parent
      }
    }

    return nil
  }

  static func needsPrivate(_ property: VariableDeclSyntax) -> Bool {
    guard owner(of: property) != nil,
          PropertyLayout(property).visibility != 3,
          !property.modifiers.contains(where: { ["static", "class"].contains($0.name.text) })
    else { return false }

    return property.bindings.contains { $0.pattern.as(IdentifierPatternSyntax.self)?.identifier.text != "body" }
  }

  static func edits(in members: MemberBlockItemListSyntax, layout: SourceLayout) -> [SourceEdit] {
    guard let owner = owner(of: members), owner.inheritanceClause?.inheritedTypes.count == 1 else { return [] }

    let properties = members.compactMap { $0.decl.as(VariableDeclSyntax.self) }.filter(needsPrivate)
    guard !properties.isEmpty else { return [] }

    let hasInitializer = owner.memberBlock.members.contains { $0.decl.is(InitializerDeclSyntax.self) }

    let needsInitializer = !hasInitializer && properties.contains { PropertyLayout($0).isStored }

    let initializer = needsInitializer
      && owner.memberBlock.members.id == members.id
      && !members.contains(where: { $0.decl.is(IfConfigDeclSyntax.self) })
      ? MemberwiseInitializer(members: members, preservingViewInputs: true)
      : nil

    let eligible = properties.filter { !PropertyLayout($0).isStored || hasInitializer || initializer != nil }
    var edits = eligible.compactMap(accessEdit)
    if let initializer, !edits.isEmpty {
      for member in members {
        if let replacement = initializer.declarations[member.id] {
          // Replace initializer defaults separately from access tokens.
          let prefix = zip(member.description.utf8, replacement.utf8).prefix { $0 == $1 }.count
          let suffix = zip(member.description.utf8.reversed(), replacement.utf8.reversed()).prefix { $0 == $1 }.count
          let start = member.position.utf8Offset
          edits.append(SourceEdit(
            range: (start + prefix)..<(member.endPosition.utf8Offset - suffix),
            replacement: String(decoding: replacement.utf8.dropFirst(prefix).dropLast(suffix), as: UTF8.self)
          ))
        }
      }

      let indent = String(repeating: " ", count: layout.indent(owner) + 2)
      let newline = members.description.contains("\r\n") ? "\r\n" : "\n"
      let source = newline + newline + indent + initializer.source.replacingOccurrences(of: "\n", with: newline + indent)
      let end = members.endPosition.utf8Offset
      edits.append(SourceEdit(range: end..<end, replacement: source))
    }
    return edits
  }

  private static func isView(_ declaration: StructDeclSyntax) -> Bool {
    declaration.inheritanceClause?.inheritedTypes.contains {
      ["View", "SwiftUI.View"].contains($0.type.trimmedDescription)
    } == true
  }

  private static func accessEdit(_ property: VariableDeclSyntax) -> SourceEdit? {
    let access = property.modifiers.filter { ["open", "public", "internal", "fileprivate", "private"].contains(
      $0.name.text
    ) }
    guard access.allSatisfy({ $0.detail == nil }), access.count <= 1 else { return nil }
    if let modifier = access.first {
      return SourceEdit(
        range: modifier.name.positionAfterSkippingLeadingTrivia.utf8Offset..<modifier.name.endPositionBeforeTrailingTrivia.utf8Offset,
        replacement: "private"
      )
    }

    let position = property.bindingSpecifier.positionAfterSkippingLeadingTrivia.utf8Offset
    return SourceEdit(range: position..<position, replacement: "private ")
  }
}
