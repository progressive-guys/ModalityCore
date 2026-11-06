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

  /// Keeps stored-property attributes inline through column 120, including indentation.
  func checkStoredPropertyAttributes(_ declaration: VariableDeclSyntax) {
    let attributes = declaration.attributes.compactMap { $0.as(AttributeSyntax.self) }
    if attributes.count != declaration.attributes.count
      || attributes.contains(where: { $0.attributeName.trimmedDescription == "available" })
    {
      checkDeclarationAttributes(declaration.attributes, indent: layout.indent(declaration))
      return
    }

    guard attributes.allSatisfy({ layout.line($0) == layout.endLine($0) }),
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

    // Keep comments between attributes and the declaration in place.
    guard zip(ends, starts).allSatisfy({ left, right in
      let range = left.endPositionBeforeTrailingTrivia.utf8Offset..<right.positionAfterSkippingLeadingTrivia.utf8Offset
      return String(decoding: bytes[range], as: UTF8.self).allSatisfy(\.isWhitespace)
    })
    else { return }

    for (left, right) in zip(ends, starts) {
      let replacement = wraps && right.id == body.id ? lineBreak(indent: layout.indent(declaration)) : " "
      let range = left.endPositionBeforeTrailingTrivia.utf8Offset..<right.positionAfterSkippingLeadingTrivia.utf8Offset
      guard String(decoding: bytes[range], as: UTF8.self) != replacement else { continue }
      if permitsFix(.propertyGrouping) { gap(after: left, before: right, with: replacement) }

      report(.propertyGrouping, right, reason: "Keep stored-property attributes inline through column 120.")
    }
  }

  /// Puts each declaration attribute on a separate line, including conditional attributes.
  /// Joins import attributes when the gap contains only whitespace.
  /// Keeps trailing objc and concurrent attributes with a declaration through column 120.
  /// Keeps protocol member attributes on the declaration line through column 120.
  /// Gives available attributes a separate line in every declaration.
  /// Keeps comments and line breaks inside attribute arguments.
  func checkDeclarationAttributes(_ attributes: AttributeListSyntax, indent: Int, inline: Bool = false) {
    let bytes = Array(source.utf8)
    let inlineStart = inlineAttributeStart(attributes, indent: indent)
    for attribute in attributes {
      if let configuration = attribute.as(IfConfigDeclSyntax.self) {
        for clause in configuration.clauses {
          if let branch = clause.elements?.as(AttributeListSyntax.self) {
            checkDeclarationAttributes(branch, indent: indent)
          }
        }
      }

      guard let left = attribute.lastToken(viewMode: .sourceAccurate),
            let right = left.nextToken(viewMode: .sourceAccurate)
      else { continue }
      let range = left.endPositionBeforeTrailingTrivia.utf8Offset..<right.positionAfterSkippingLeadingTrivia.utf8Offset
      let trivia = String(decoding: bytes[range], as: UTF8.self)

      let attributeStart = attribute.positionAfterSkippingLeadingTrivia.utf8Offset

      let separatesAvailability = attribute.as(AttributeSyntax.self)?.attributeName.trimmedDescription == "available"
        || right.ancestor(AttributeSyntax.self)?.attributeName.trimmedDescription == "available"

      let joinsDeclaration = !separatesAvailability && (inline || inlineStart.map { attributeStart >= $0 } == true)
      guard !joinsDeclaration || trivia.allSatisfy(\.isWhitespace) else { continue }
      let trailingWhitespace = trivia.reversed().prefix(while: \.isWhitespace).count
      let comments = trivia.prefix(trivia.count - trailingWhitespace)
      let replacement = joinsDeclaration ? " " : String(comments) + lineBreak(indent: indent)
      guard trivia != replacement else { continue }

      if permitsFix(.attributeNewline) {
        edits.append(SourceEdit(range: range, replacement: replacement))
      }

      let reason: String? = if inline {
        "Keep import attributes on the import line."
      } else if joinsDeclaration {
        "Keep attributes with the declaration through column 120."
      } else {
        nil
      }

      report(.attributeNewline, right, reason: reason)
    }
  }

  /// Finds a trailing attribute group that fits on the first declaration line.
  private func inlineAttributeStart(_ attributes: AttributeListSyntax, indent: Int) -> Int? {
    let isProtocolMember = attributes.ancestor(MemberBlockSyntax.self)?.parent?.is(ProtocolDeclSyntax.self) == true
    let isStoredProperty = attributes.parent?.as(VariableDeclSyntax.self).map { PropertyLayout($0).isStored } == true
    let candidates = attributes.reversed()
      .prefix { element in
        guard let attribute = element.as(AttributeSyntax.self) else { return false }
        let name = attribute.attributeName.trimmedDescription
        let canBeInline = isStoredProperty || isProtocolMember || ["objc", "concurrent"].contains(name)
        return name != "available" && canBeInline
          && layout.line(attribute) == layout.endLine(attribute)
      }
      .reversed()
    guard let first = candidates.first,
          let last = candidates.last?.lastToken(viewMode: .sourceAccurate),
          let body = last.nextToken(viewMode: .sourceAccurate),
          let declaration = attributes.parent?.as(DeclSyntax.self)
    else { return nil }

    let bytes = Array(source.utf8)

    let bodyText = String(decoding: bytes[
      body.positionAfterSkippingLeadingTrivia.utf8Offset..<declaration.endPositionBeforeTrailingTrivia.utf8Offset
    ], as: UTF8.self)
    let firstLine = bodyText.split(whereSeparator: { $0.isNewline }).first.map(String.init) ?? ""
    let attributeText = candidates.map(\.trimmedDescription).joined(separator: " ")
    guard indent + attributeText.count + 1 + firstLine.count <= 120 else { return nil }

    return first.positionAfterSkippingLeadingTrivia.utf8Offset
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
