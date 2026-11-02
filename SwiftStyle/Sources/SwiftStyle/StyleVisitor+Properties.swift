import SwiftSyntax

extension StyleVisitor {

  /// Groups stored properties by read visibility, static/let/var/attribute kind, type and attribute name.
  /// Checks order across methods. Counts group size within consecutive property runs.
  /// Types and attribute kinds follow their first occurrence. Checks each conditional branch independently.
  /// Separates groups with more than three declared properties.
  /// Separates stored let and var declarations regardless of group size.
  /// Sorts stored properties by line length. Computed properties keep order within each effect group.
  /// Also separates computed properties longer than three lines from any adjacent member.
  func checkPropertyGrouping(_ members: MemberBlockItemListSyntax) {
    var run: [PropertyLayout] = []
    var properties: [SyntaxIdentifier: PropertyLayout] = [:]
    var counts: [SyntaxIdentifier: [[String]: Int]] = [:]

    for member in members {
      switch (Syntax(member.decl).as(SyntaxEnum.self)) {
      case .variableDecl(let declaration):
        let property = PropertyLayout(declaration)

        checkPropertyAttributes(declaration)

        if property.isStored {
          run.append(property)
        } else {
          countPropertyRun(run, counts: &counts)
          run = []
        }

        properties[declaration.id] = property

      default:
        countPropertyRun(run, counts: &counts)
        run = []
      }
    }

    countPropertyRun(run, counts: &counts)
    checkPropertyOrder(members)

    for (previous, current) in zip(members, members.dropFirst()) {
      let left = properties[previous.decl.id]
      let right = properties[current.decl.id]

      guard left != nil || right != nil,
            let spacing = layout.groupSpacing(between: previous, and: current),
            let token = current.decl.firstToken(viewMode: .sourceAccurate)
      else { continue }

      let longAccessor = left?.hasLongAccessor(in: layout) == true || right?.hasLongAccessor(in: layout) == true
      let largeGroup = separatesLargeGroup(left, right, counts: counts)
      let sectionBoundary = left != nil && right != nil && left?.isStored != right?.isStored

      let bindingBoundary = left?.isStored == true && right?.isStored == true
        && left?.declaration.bindingSpecifier.text != right?.declaration.bindingSpecifier.text

      let effectBoundary = left?.isStored == false && right?.isStored == false
        && MemberOrderFormatter.effects(of: previous.decl) != MemberOrderFormatter.effects(of: current.decl)

      if longAccessor || largeGroup || sectionBoundary || bindingBoundary || effectBoundary {
        if spacing.blankLines.count != 1 {
          let reason = if longAccessor {
            "Separate a computed property longer than three lines with one blank line."

          } else if bindingBoundary {
            "Separate stored let and var declarations with one blank line."
          } else if effectBoundary {
            "Separate getter effect groups with one blank line."
          } else if sectionBoundary {
            "Separate stored and computed properties with one blank line."
          } else {
            "Separate a property group of more than three elements with one blank line."
          }

          fixSpacing(spacing.blankLines, required: 1, rule: .propertyGrouping)
          report(.propertyGrouping, token, reason: reason)
        }
      } else if left != nil, right != nil, spacing.blankLines.count != spacing.required {
        fixSpacing(spacing.blankLines, required: spacing.required, rule: .propertyGrouping)

        report(
          .propertyGrouping,
          token,
          reason: "Keep declaration groups compact and separate multiline properties with one blank line."
        )
      }
    }
  }

  /// Keeps property attributes inline through column 120. Preserves comments and multiline arguments.
  private func checkPropertyAttributes(_ declaration: VariableDeclSyntax) {
    let attributes = declaration.attributes.compactMap { $0.as(AttributeSyntax.self) }

    guard !attributes.isEmpty, attributes.count == declaration.attributes.count,
          attributes.allSatisfy({ layout.line($0) == layout.endLine($0) }),
          let last = attributes.last?.lastToken(viewMode: .sourceAccurate),
          let body = last.nextToken(viewMode: .sourceAccurate)
    else { return }

    let bytes = Array(source.utf8)

    let bodyText = String(decoding: bytes[
      body.positionAfterSkippingLeadingTrivia.utf8Offset..<declaration.endPositionBeforeTrailingTrivia.utf8Offset
    ], as: UTF8.self)

    let firstLine = bodyText.split(whereSeparator: { $0.isNewline }).first.map(String.init) ?? ""
    let attributeText = attributes.map(\.trimmedDescription).joined(separator: " ")
    let wraps = layout.indent(declaration) + attributeText.count + 1 + firstLine.count > 120
    let ends = attributes.compactMap { $0.lastToken(viewMode: .sourceAccurate) }
    let starts = Array(attributes.dropFirst()).compactMap { $0.firstToken(viewMode: .sourceAccurate) } + [body]

    // A comment between attributes or before the declaration keeps its original position.
    guard zip(ends, starts).allSatisfy({ left, right in
      let gap = left.endPositionBeforeTrailingTrivia.utf8Offset..<right.positionAfterSkippingLeadingTrivia.utf8Offset
      return String(decoding: bytes[gap], as: UTF8.self).allSatisfy(\.isWhitespace)
    })
    else { return }

    for (left, right) in zip(ends, starts) {
      let replacement = wraps && right.id == body.id ? lineBreak(indent: layout.indent(declaration)) : " "
      let range = left.endPositionBeforeTrailingTrivia.utf8Offset..<right.positionAfterSkippingLeadingTrivia.utf8Offset

      guard String(decoding: bytes[range], as: UTF8.self) != replacement else { continue }
      if permitsFix(.propertyGrouping) { gap(after: left, before: right, with: replacement) }

      report(.propertyGrouping, right, reason: "Keep property attributes inline unless the line exceeds 120 columns.")
    }
  }

  private func checkPropertyOrder(_ members: MemberBlockItemListSyntax) {
    let grouping = PropertyGrouping(members, layout: layout)
    let ranks = Dictionary(uniqueKeysWithValues: grouping.sorted.enumerated().map { ($0.element.member.id, $0.offset) })
    var previous = 0

    for slot in grouping.slots {
      let rank = ranks[slot.member.id, default: 0]

      if rank < previous {
        report(
          .propertyGrouping,
          slot.property.declaration.bindingSpecifier,
          reason: "Group stored properties by visibility, kind, type and attribute; sort each block by length."
        )
      }

      previous = max(previous, rank)
    }
  }

  private func countPropertyRun(_ properties: [PropertyLayout], counts: inout [SyntaxIdentifier: [[String]: Int]]) {
    let sizes = PropertyGrouping.sizes(properties)

    for property in properties {
      counts[property.declaration.id] = sizes
    }
  }

  private func separatesLargeGroup(
    _ left: PropertyLayout?,
    _ right: PropertyLayout?,
    counts: [SyntaxIdentifier: [[String]: Int]]
  ) -> Bool {
    let leftGroups = Set(left?.isStored == true ? left?.groups ?? [] : [])
    let rightGroups = Set(right?.isStored == true ? right?.groups ?? [] : [])
    let leftCounts = left.flatMap { counts[$0.declaration.id] } ?? [:]
    let rightCounts = right.flatMap { counts[$0.declaration.id] } ?? [:]

    return leftGroups.subtracting(rightGroups).contains { leftCounts[$0, default: 0] > 3 }
      || rightGroups.subtracting(leftGroups).contains { rightCounts[$0, default: 0] > 3 }
  }
}
