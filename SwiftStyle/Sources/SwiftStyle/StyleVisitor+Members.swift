import SwiftSyntax

extension StyleVisitor {

  private enum MemberKind {

    case property
    case method
    case initializer
    case deinitializer
    case subscriptMember
    case associatedType
    case nestedType
  }

  /// Uses stable section order. Conditional branches are checked independently.
  func checkMemberOrder(_ members: MemberBlockItemListSyntax) {
    for group in MemberOrderFormatter.groups(in: members) {
      let ranks = Dictionary(uniqueKeysWithValues: MemberOrderFormatter.sorted(group).enumerated().map {
        ($0.element.id, $0.offset)
      })

      var previous = 0

      for member in group {
        let rank = ranks[member.id, default: 0]
        if rank < previous, let token = member.decl.firstToken(viewMode: .sourceAccurate) {
          report(.memberOrder, token)
        }
        previous = max(previous, rank)
      }
    }
  }

  /// Keeps single-line members of the same kind together. Separates multiline members and different kinds.
  /// Includes comments and attributes. A change of member kind or a MARK comment starts a separate group.
  /// Checks type and extension members, including protocol requirements and each conditional branch.
  func checkMemberSpacing(_ members: MemberBlockItemListSyntax) {
    checkMemberBlockOpening(members)

    for (previous, current) in zip(members, members.dropFirst()) {
      if MemberOrderFormatter.separatesEffects(previous, current),
         let spacing = layout.groupSpacing(between: previous, and: current),
         let token = current.decl.firstToken(viewMode: .sourceAccurate)
      {
        if spacing.blankLines.count != 1 {
          fixSpacing(spacing.blankLines, required: 1, rule: .memberSpacing)
          report(.memberSpacing, token)
        }

        continue
      }

      guard let left = memberKind(previous.decl),
            let right = memberKind(current.decl),
            left != .property || right != .property,
            !layout.hasSectionMarker(current),
            let spacing = layout.groupSpacing(between: previous, and: current),
            let token = current.decl.firstToken(viewMode: .sourceAccurate)
      else { continue }
      let required = left == .nestedType || right == .nestedType || left != right ? 1 : spacing.required
      if spacing.blankLines.count != required {
        fixSpacing(spacing.blankLines, required: required, rule: .memberSpacing)
        report(.memberSpacing, token)
      }
    }
  }

  /// Uses no opening blank line through three code lines, then one before the first member or comment.
  /// Empty bodies and conditional branch lists have no opening separator to check.
  private func checkMemberBlockOpening(_ members: MemberBlockItemListSyntax) {
    guard let body = members.parent?.as(MemberBlockSyntax.self),
          let first = members.first
    else { return }
    let spacing = layout.groupSpacing(between: body.leftBrace, and: first)

    let required = memberOpeningBlankLines(members)
    if spacing?.blankLines.count != required {
      if let spacing { fixSpacing(spacing.blankLines, required: required, rule: .memberSpacing) }

      let reason = required == 0
        ? "Remove the opening blank line from a body with at most three code lines."
        : "Put one blank line after the type opening brace."
      report(.memberSpacing, body.leftBrace, reason: reason)
    }
  }

  /// Counts code lines in the body, including nested code and excluding comments.
  func memberOpeningBlankLines(_ members: MemberBlockItemListSyntax) -> Int {
    layout.codeLineCount(members) <= 3 ? 0 : 1
  }

  private func memberKind(_ declaration: DeclSyntax) -> MemberKind? {
    switch declaration.as(DeclSyntaxEnum.self) {
    case .variableDecl: .property
    case .functionDecl: .method
    case .initializerDecl: .initializer
    case .deinitializerDecl: .deinitializer
    case .subscriptDecl: .subscriptMember
    case .associatedTypeDecl: .associatedType
    case .structDecl, .classDecl, .actorDecl, .enumDecl, .protocolDecl, .typeAliasDecl: .nestedType
    default: nil
    }
  }
}
