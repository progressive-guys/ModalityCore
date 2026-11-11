import SwiftSyntax

/// Sorts property slots. Methods and other declarations keep their positions.
enum PropertyOrderFormatter {

  static func edits(in members: MemberBlockItemListSyntax, layout: SourceLayout) -> [SourceEdit] {
    let grouping = PropertyGrouping(members, layout: layout)
    let original = grouping.slots.map(\.member)
    let ordered = grouping.sorted.map(\.member)
    guard zip(original, ordered).contains(where: { $0.id != $1.id }),
          MemberOrderFormatter.preservesOrder(
            in: members,
            replacing: original,
            with: ordered,
            of: MemberOrderFormatter.requiresInitializerOrder
          )
    else { return [] }

    let changesParameters = !MemberOrderFormatter.preservesOrder(
      in: members,
      replacing: original,
      with: ordered,
      of: hasParameter
    )

    let initializer = changesParameters ? MemberwiseInitializer(members: members) : nil
    if initializer == nil, let owner = members.ancestor(MemberBlockSyntax.self)?.parent?.as(StructDeclSyntax.self),
       !owner.memberBlock.members.contains(where: { $0.decl.is(InitializerDeclSyntax.self) }),
       changesParameters
    { return [] }

    let start = members.position.utf8Offset
    var bytes = Array(members.description.utf8)

    for (slot, replacement) in zip(original, ordered).reversed() {
      let lower = slot.position.utf8Offset - start
      let upper = slot.endPosition.utf8Offset - start
      var text = initializer?.declarations[replacement.id] ?? replacement.description
      if let trivia = grouping.leadingTrivia[replacement.id] {
        let count = replacement.leadingTrivia.sourceLength.utf8Length
        text = trivia.description + String(decoding: text.utf8.dropFirst(count), as: UTF8.self)
      }
      bytes.replaceSubrange(lower..<upper, with: text.utf8)
    }
    var result = String(decoding: bytes, as: UTF8.self)
    if let initializer {
      let token = members.first?.firstToken(viewMode: .sourceAccurate)
      let prefix = token?.leadingTrivia.description.split(whereSeparator: \.isNewline).last.map(String.init) ?? "  "
      let indent = String(prefix.prefix(while: { $0 == " " || $0 == "\t" }))

      let newline = result.contains("\r\n") ? "\r\n" : "\n"

      result += newline
        + newline
        + indent
        + initializer.source.replacingOccurrences(of: "\n", with: newline + indent)
    }
    return [SourceEdit(range: start..<members.endPosition.utf8Offset, replacement: result)]
  }

  /// A conditional field or a member macro can contribute parameters to the synthesized initializer.
  private static func hasParameter(_ member: MemberBlockItemSyntax) -> Bool {
    switch member.decl.as(DeclSyntaxEnum.self) {
    case .variableDecl(let property):
      return PropertyLayout(property).isStored
        && !property.modifiers.contains { ["static", "class"].contains($0.name.text) }
        && property.bindings.contains { property.bindingSpecifier.text != "let" || $0.initializer == nil }

    case .ifConfigDecl(let configuration):
      return configuration.clauses.contains { clause in
        clause.elements?.as(MemberBlockItemListSyntax.self)?.contains(where: hasParameter) ?? true
      }

    case .macroExpansionDecl: return true
    default: return false
    }
  }
}
