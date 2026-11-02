import SwiftSyntax

/// Sorts property slots. Methods and other declarations keep their positions.
enum PropertyOrderFormatter {

  static func edits(in members: MemberBlockItemListSyntax, layout: SourceLayout) -> [SourceEdit] {
    let grouping = PropertyGrouping(members, layout: layout)
    let slots = grouping.slots.map { ($0.member, $0.property) }
    let sorted = grouping.sorted.map { ($0.member, $0.property) }

    guard zip(slots, sorted).contains(where: { $0.0.id != $1.0.id }) else { return [] }

    let initializer = MemberwiseInitializer(members: members)

    // Keep a synthesized initializer when its parameter types cannot be resolved from syntax.
    if ({ () -> Bool? in
      switch (Syntax(members.parent?.parent)?.as(SyntaxEnum.self)) {
      case .structDecl?: return true
      case nil: return nil
      default: return false
      }
    }()) == true,
       !members.contains(where: { $0.decl.is(InitializerDeclSyntax.self) }), initializer == nil
    {
      let stored = slots.compactMap { slot -> SyntaxIdentifier? in
        let property = slot.1.declaration

        guard !property.modifiers.contains(where: { ["static", "class"].contains($0.name.text) }) else { return nil }

        let hasParameter = property.bindings.contains { binding in
          if property.bindingSpecifier.text == "let", binding.initializer != nil { return false }

          if let accessors = binding.accessorBlock {
            switch accessors.accessors {
            case .getter: return false
            case .accessors(let list):
              return !list.contains { ["get", "set", "_read", "_modify"].contains($0.accessorSpecifier.text) }
            @unknown default: return true
            }
          }

          return true
        }

        return hasParameter ? slot.0.id : nil
      }

      let sortedStored = sorted.map { $0.0.id }.filter { stored.contains($0) }

      if stored != sortedStored { return [] }
    }

    let start = members.position.utf8Offset
    var bytes = Array(members.description.utf8)

    for (original, replacement) in zip(slots, sorted).reversed() {
      let lower = original.0.position.utf8Offset - start
      let upper = original.0.endPosition.utf8Offset - start
      var text = initializer?.declarations[replacement.0.id] ?? replacement.0.description

      if let trivia = grouping.leadingTrivia[replacement.0.id] {
        let count = replacement.0.leadingTrivia.sourceLength.utf8Length
        text = trivia.description + String(decoding: text.utf8.dropFirst(count), as: UTF8.self)
      }

      bytes.replaceSubrange(lower..<upper, with: text.utf8)
    }

    var result = String(decoding: bytes, as: UTF8.self)

    if let initializer {
      let token = members.first?.firstToken(viewMode: .sourceAccurate)
      let prefix = token?.leadingTrivia.description.split(separator: "\n").last.map(String.init) ?? "  "
      let indent = String(prefix.prefix(while: { $0 == " " || $0 == "\t" }))
      let newline = result.contains("\r\n") ? "\r\n" : "\n"

      result += newline
        + newline
        + indent
        + initializer.source.replacingOccurrences(of: "\n", with: newline + indent)
    }

    return [SourceEdit(range: start..<members.endPosition.utf8Offset, replacement: result)]
  }
}
