import SwiftSyntax

extension StyleVisitor {

  /// Keeps single-line members of the same kind together. Separates multiline members and different kinds.
  /// Includes comments and attributes. A change of member kind or a MARK comment starts a separate group.
  /// Checks type and extension members, including protocol requirements and each conditional branch.
  func checkMemberSpacing(_ members: MemberBlockItemListSyntax) {
    checkMemberBlockOpening(members)
    for (previous, current) in zip(members, members.dropFirst()) {
      guard let left = memberKind(previous.decl),
            let right = memberKind(current.decl),
            left != .property || right != .property,
            !layout.hasSectionMarker(current),
            let spacing = layout.groupSpacing(between: previous, and: current),
            spacing.blankLines.count != (left != right ? 1 : spacing.required),
            let token = current.decl.firstToken(viewMode: .sourceAccurate)
      else { continue }

      report(.memberSpacing, token)
    }
  }

  /// Requires one blank line before the first member, including its leading comments.
  /// Empty bodies and conditional branch lists have no opening separator to check.
  private func checkMemberBlockOpening(_ members: MemberBlockItemListSyntax) {
    guard let body = members.parent?.as(MemberBlockSyntax.self),
          let first = members.first
    else { return }

    let spacing = layout.groupSpacing(between: body.leftBrace, and: first)
    if spacing?.blankLines.count != 1 {
      report(.memberSpacing, body.leftBrace, reason: "Put one blank line after the type opening brace.")
    }
  }

  private func memberKind(_ declaration: DeclSyntax) -> MemberKind? {
    switch declaration.as(DeclSyntaxEnum.self) {
    case .variableDecl: .property
    case .functionDecl: .method
    case .initializerDecl: .initializer
    case .subscriptDecl: .subscriptMember
    case .associatedTypeDecl: .associatedType
    default: nil
    }
  }

  private enum MemberKind {

    case property
    case method
    case initializer
    case subscriptMember
    case associatedType
  }
}
