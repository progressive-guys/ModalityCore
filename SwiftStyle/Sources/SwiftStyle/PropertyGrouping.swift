import SwiftSyntax

/// Groups and sorts stored properties. Computed properties keep their member slots.
struct PropertyGrouping {

  typealias Slot = (member: MemberBlockItemSyntax, property: PropertyLayout)

  let slots: [Slot]
  let sorted: [Slot]
  let leadingTrivia: [SyntaxIdentifier: Trivia]

  init(_ members: MemberBlockItemListSyntax, layout: SourceLayout) {
    slots = members.compactMap { member in
      switch member.decl.as(DeclSyntaxEnum.self) {
      case .variableDecl(let declaration) where PropertyLayout(declaration).isStored: (
        member,
        PropertyLayout(declaration)
      )

      default: nil
      }
    }

    var typeOrder: [[String]: [String]] = [:]
    var annotationOrder: [[String]: [String]] = [:]
    var keys: [SyntaxIdentifier: [Int]] = [:]
    for (index, slot) in slots.enumerated() {
      let property = slot.property
      let group = [String(property.visibility), String(property.kind)]
      let type = property.type ?? "unknown:\(index)"
      if !typeOrder[group, default: []].contains(type) { typeOrder[group, default: []].append(type) }
      let annotations = property.annotations.joined(separator: ",")
      let annotationGroup = group
      if !annotationOrder[annotationGroup, default: []].contains(annotations) {
        annotationOrder[annotationGroup, default: []].append(annotations)
      }
      keys[slot.member.id] = [
        property.visibility,
        property.kind,
        annotationOrder[annotationGroup]?.firstIndex(of: annotations) ?? index,
        typeOrder[group]?.firstIndex(of: type) ?? index,
        index
      ]
    }
    let hierarchy = slots.sorted {
      (keys[$0.member.id] ?? []).lexicographicallyPrecedes(keys[$1.member.id] ?? [])
    }

    let propertyIDs = Set(slots.map { $0.member.id })
    var index = 0
    var run: [Slot] = []
    var result: [Slot] = []
    var trivia: [SyntaxIdentifier: Trivia] = [:]

    for member in members {
      if propertyIDs.contains(member.id) {
        run.append(hierarchy[index])
        index += 1
      } else {
        result += Self.sort(run, layout: layout, leadingTrivia: &trivia)
        run = []
      }
    }
    result += Self.sort(run, layout: layout, leadingTrivia: &trivia)
    sorted = result
    leadingTrivia = trivia
  }

  static func sizes(_ properties: [PropertyLayout]) -> [[String]: Int] {
    var counts: [[String]: Int] = [:]
    for property in properties {
      for group in Set(property.groups) { counts[group, default: 0] += property.elementCount }
    }
    return counts
  }

  static func separatesLargeGroup(_ left: PropertyLayout, _ right: PropertyLayout, sizes: [[String]: Int]) -> Bool {
    let leftGroups = Set(left.groups)
    let rightGroups = Set(right.groups)
    return leftGroups.symmetricDifference(rightGroups).contains { sizes[$0, default: 0] > 3 }
  }

  private static func sort(_ run: [Slot], layout: SourceLayout, leadingTrivia: inout [SyntaxIdentifier: Trivia]) -> [
    Slot
  ] {
    let counts = sizes(run.map { $0.property })
    var block: [Slot] = []
    var result: [Slot] = []
    for slot in run {
      if let previous = block.last {
        let separates = separatesLargeGroup(previous.property, slot.property, sizes: counts)
          || layout.hasGroupHeader(slot.member)
          || !layout.isSingleLineGroupElement(previous.member)
          || !layout.isSingleLineGroupElement(slot.member)
        if separates {
          result += byLength(block, layout: layout, leadingTrivia: &leadingTrivia)
          block = []
        }
      }

      block.append(slot)
    }
    return result + byLength(block, layout: layout, leadingTrivia: &leadingTrivia)
  }

  private static func byLength(
    _ slots: [Slot],
    layout: SourceLayout,
    leadingTrivia: inout [SyntaxIdentifier: Trivia]
  ) -> [Slot] {
    // Keep attribute groups together before sorting their declarations by length.
    var annotations: [[String]] = []
    for slot in slots where !annotations.contains(slot.property.annotations) {
      annotations.append(slot.property.annotations)
    }
    let indexed = slots.enumerated().sorted {
      let left = $0.element.property
      let right = $1.element.property
      let leftGroup = annotations.firstIndex(of: left.annotations) ?? $0.offset
      let rightGroup = annotations.firstIndex(of: right.annotations) ?? $1.offset
      return [left.visibility, left.kind, leftGroup, left.lineLength, $0.offset]
        .lexicographicallyPrecedes([right.visibility, right.kind, rightGroup, right.lineLength, $1.offset])
    }
    let sorted = indexed.map { $0.element }
    leadingTrivia.merge(
      layout.groupHeaderTrivia(first: slots.first?.member, sortedFirst: sorted.first?.member),
      uniquingKeysWith: { _, next in next }
    )
    return sorted
  }
}
