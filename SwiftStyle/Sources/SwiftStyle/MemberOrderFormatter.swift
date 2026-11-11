import SwiftSyntax

/// Orders aliases, nested types, stored properties, initializers, deinitializers, subscripts, getters and functions.
/// Groups getters and functions by effects and keeps source order within each group.
enum MemberOrderFormatter {

  static func groups(in members: MemberBlockItemListSyntax) -> [[MemberBlockItemSyntax]] {
    var groups: [[MemberBlockItemSyntax]] = []
    var group: [MemberBlockItemSyntax] = []
    for member in members {
      switch (Syntax(member.decl).as(SyntaxEnum.self)) {
      case .ifConfigDecl where rank(member) == nil, .macroExpansionDecl:
        if !group.isEmpty { groups.append(group) }
        group = []

      case .typeAliasDecl, .structDecl, .classDecl, .actorDecl, .enumDecl, .protocolDecl, .associatedTypeDecl,
        .variableDecl, .initializerDecl, .deinitializerDecl, .subscriptDecl, .functionDecl, .ifConfigDecl:
        group.append(member)

      default: break
      }
    }
    if !group.isEmpty { groups.append(group) }
    return groups
  }

  static func sorted(_ group: [MemberBlockItemSyntax]) -> [MemberBlockItemSyntax] {
    let ordered = group.enumerated().sorted {
      [rank($0.element) ?? 0, $0.offset].lexicographicallyPrecedes([rank($1.element) ?? 0, $1.offset])
    }

    return ordered.map(\.element)
  }

  static func edits(in members: MemberBlockItemListSyntax) -> [SourceEdit] {
    groups(in: members).compactMap { group in
      let ordered = sorted(group)
      guard let first = group.first, let last = group.last,
            zip(group, ordered).contains(where: { $0.id != $1.id }),
            preservesOrder(in: members, replacing: group, with: ordered, of: requiresInitializerOrder)
      else { return nil }

      let start = first.position.utf8Offset
      let end = last.endPosition.utf8Offset

      let offset = members.position.utf8Offset

      var bytes = Array(members.description.utf8)[(start - offset)..<(end - offset)]

      for (original, replacement) in zip(group, ordered).reversed() {
        let lower = original.position.utf8Offset - offset
        let upper = original.endPosition.utf8Offset - offset
        bytes.replaceSubrange(lower..<upper, with: replacement.description.utf8)
      }

      return SourceEdit(range: start..<end, replacement: String(decoding: bytes, as: UTF8.self))
    }
  }

  /// Includes members between replacement slots, such as conditional declarations and member macros.
  static func preservesOrder(
    in members: MemberBlockItemListSyntax,
    replacing original: [MemberBlockItemSyntax],
    with ordered: [MemberBlockItemSyntax],
    of requiresOrder: (MemberBlockItemSyntax) -> Bool
  ) -> Bool {
    let protected = members.compactMap { requiresOrder($0) ? $0.id : nil }
    let ids = Set(protected)

    let replacements = Dictionary(uniqueKeysWithValues: zip(original.map(\.id), ordered.map(\.id)))

    return members.map { replacements[$0.id] ?? $0.id }.filter(ids.contains) == protected
  }

  /// A conditional declaration keeps its slot relative to other explicit initializer computations.
  static func requiresInitializerOrder(_ member: MemberBlockItemSyntax) -> Bool {
    switch member.decl.as(DeclSyntaxEnum.self) {
    case .variableDecl(let declaration):
      // A type property initializes on first access, independent of its slot.
      let property = PropertyLayout(declaration)
      return property.kind != 0 && property.isStored && property.evaluatesInitializer

    case .ifConfigDecl(let configuration):
      return configuration.clauses.contains { clause in
        guard let branch = clause.elements?.as(MemberBlockItemListSyntax.self) else { return true }
        return branch.contains(where: requiresInitializerOrder)
      }

    case .macroExpansionDecl: return true
    default: return false
    }
  }

  private static func rank(_ member: MemberBlockItemSyntax) -> Int? {
    switch member.decl.as(DeclSyntaxEnum.self) {
    case .typeAliasDecl: 0
    case .structDecl, .classDecl, .actorDecl, .enumDecl, .protocolDecl, .associatedTypeDecl: 4
    case .variableDecl(let declaration): PropertyLayout(declaration).isStored ? 8 : 24 + effects(of: member.decl)
    case .initializerDecl: 12
    case .deinitializerDecl: 16
    case .subscriptDecl: 20
    case .functionDecl: 28 + effects(of: member.decl)
    case .ifConfigDecl(let configuration): conditionalRank(configuration)
    default: nil
    }
  }

  /// Orders plain, throwing, async and async throwing declarations from their signatures.
  static func effects(of declaration: DeclSyntax) -> Int {
    switch declaration.as(DeclSyntaxEnum.self) {
    case .functionDecl(let function):
      let effects = function.signature.effectSpecifiers
      return (effects?.asyncSpecifier == nil ? 0 : 2) + (effects?.throwsClause == nil ? 0 : 1)

    case .variableDecl(let property):
      return property.bindings
        .compactMap { binding -> Int? in
        guard case .accessors(let accessors)? = binding.accessorBlock?.accessors,
              let getter = accessors.first(where: { $0.accessorSpecifier.text == "get" })
        else { return nil }

        let effects = getter.effectSpecifiers
        return (effects?.asyncSpecifier == nil ? 0 : 2) + (effects?.throwsClause == nil ? 0 : 1)
      }
        .max() ?? 0

    default: return 0
    }
  }

  /// Includes conditional blocks that have one section and one effect group.
  static func separatesEffects(_ left: MemberBlockItemSyntax, _ right: MemberBlockItemSyntax) -> Bool {
    guard let leftRank = rank(left), let rightRank = rank(right), leftRank >= 24,
          leftRank / 4 == rightRank / 4
    else { return false }

    return leftRank != rightRank
  }

  /// A conditional block with one section and effect group moves as a unit, with its branches intact.
  /// Mixed sections or effects keep their boundary; each branch receives its own order check.
  private static func conditionalRank(_ configuration: IfConfigDeclSyntax) -> Int? {
    var ranks: Set<Int> = []
    for clause in configuration.clauses {
      guard case .memberBlockItemList(let members)? = Syntax(clause.elements)?.as(SyntaxEnum.self) else { return nil }
      for member in members {
        if let value = rank(member) {
          ranks.insert(value)
        } else {
          switch member.decl.as(DeclSyntaxEnum.self) {
          case .ifConfigDecl, .macroExpansionDecl: return nil
          default: break
          }
        }
      }
    }
    return ranks.count == 1 ? ranks.first : nil
  }
}
