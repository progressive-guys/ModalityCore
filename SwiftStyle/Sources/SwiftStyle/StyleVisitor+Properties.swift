import SwiftSyntax

extension StyleVisitor {

  /// Groups properties by read visibility, static/let/var/attribute kind, type and attribute name.
  /// Checks order across methods. Counts group size within consecutive property runs.
  /// Types and attribute kinds follow their first occurrence. Checks each conditional branch independently.
  /// Separates different types and attribute kinds, plus groups with more than two declared properties.
  /// Also separates computed properties longer than three lines from any adjacent member.
  func checkPropertyGrouping(_ members: MemberBlockItemListSyntax) {
    var run: [PropertyLayout] = []
    var properties: [SyntaxIdentifier: PropertyLayout] = [:]
    var counts: [SyntaxIdentifier: [[String]: Int]] = [:]
    for member in members {
      if let declaration = member.decl.as(VariableDeclSyntax.self) {
        let property = PropertyLayout(declaration)
        run.append(property)
        properties[declaration.id] = property
      } else {
        countPropertyRun(run, counts: &counts)
        run = []
      }
    }
    countPropertyRun(run, counts: &counts)
    checkPropertyOrder(members.compactMap { properties[$0.decl.id] })
    for (previous, current) in zip(members, members.dropFirst()) {
      let left = properties[previous.decl.id]
      let right = properties[current.decl.id]
      guard left != nil || right != nil,
            let spacing = layout.groupSpacing(between: previous, and: current),
            let token = current.decl.firstToken(viewMode: .sourceAccurate)
      else { continue }

      let longAccessor = left?.hasLongAccessor(in: layout) == true || right?.hasLongAccessor(in: layout) == true
      let largeGroup = separatesLargeGroup(left, right, counts: counts)
      let differentType = left?.type != nil && right?.type != nil && left?.type != right?.type
      let differentAnnotations = left != nil && right != nil && left?.annotations != right?.annotations
      if longAccessor || largeGroup || differentType || differentAnnotations {
        if spacing.blankLines.count != 1 {
          let reason = if longAccessor {
            "Separate a computed property longer than three lines with one blank line."
          } else if differentAnnotations {
            "Separate properties with different attribute kinds with one blank line."
          } else if differentType {
            "Separate properties of different types with one blank line."
          } else {
            "Separate a property group of more than two elements with one blank line."
          }
          report(.propertyGrouping, token, reason: reason)
        }
      } else if left != nil, right != nil,
                spacing.blankLines.count != spacing.required
      {
        let reason = spacing.required == 0
          ? "Keep single-line property groups of at most two elements together."
          : "Separate multiline properties with one blank line."
        report(.propertyGrouping, token, reason: reason)
      }
    }
  }

  private func checkPropertyOrder(_ properties: [PropertyLayout]) {
    var visibility = 0
    var kinds: [Int: Int] = [:]
    var previous: [[String]: String] = [:]
    var seen: [[String]: Set<String>] = [:]
    for property in properties {
      var reason: String?
      if property.visibility < visibility {
        reason = "Use this visibility order: open, public, internal, private, fileprivate."
      } else if property.kind < kinds[property.visibility, default: 0] {
        reason = "Use this property order: static, let, var, then attributed properties."
      }
      visibility = max(visibility, property.visibility)
      kinds[property.visibility] = max(kinds[property.visibility, default: 0], property.kind)
      if let type = property.type {
        let prefix = [String(property.visibility), String(property.kind)]
        for (group, value) in [(prefix, type), (prefix + [type], property.annotations.joined(separator: ","))] {
          if previous[group] != value, seen[group, default: []].contains(value) {
            reason = reason ?? (group.count == 2
              ? "Keep properties of type \(type) together."
              : "Keep properties with the same attribute kinds together."
            )
          }

          previous[group] = value
          seen[group, default: []].insert(value)
        }
      }
      if let reason { report(.propertyGrouping, property.declaration.bindingSpecifier, reason: reason) }
    }
  }

  private func countPropertyRun(_ properties: [PropertyLayout], counts: inout [SyntaxIdentifier: [[String]: Int]]) {
    var sizes: [[String]: Int] = [:]
    for property in properties {
      for group in Set(property.groups) { sizes[group, default: 0] += property.elementCount }
    }
    for property in properties {
      counts[property.declaration.id] = sizes
    }
  }

  private func separatesLargeGroup(
    _ left: PropertyLayout?,
    _ right: PropertyLayout?,
    counts: [SyntaxIdentifier: [[String]: Int]]
  ) -> Bool {
    let leftGroups = Set(left?.groups ?? [])
    let rightGroups = Set(right?.groups ?? [])
    let leftCounts = left.flatMap { counts[$0.declaration.id] } ?? [:]
    let rightCounts = right.flatMap { counts[$0.declaration.id] } ?? [:]
    return leftGroups.subtracting(rightGroups).contains { leftCounts[$0, default: 0] > 2 }
      || rightGroups.subtracting(leftGroups).contains { rightCounts[$0, default: 0] > 2 }
  }
}
