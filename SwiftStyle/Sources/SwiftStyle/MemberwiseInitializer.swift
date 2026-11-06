import SwiftSyntax

/// Keeps the memberwise call signature when stored properties move.
struct MemberwiseInitializer {

  let source: String
  let declarations: [SyntaxIdentifier: String]

  init?(members: MemberBlockItemListSyntax, preservingViewInputs: Bool = false) {
    guard members.parent?.parent?.is(StructDeclSyntax.self) == true,
          !members.contains(where: { $0.decl.is(InitializerDeclSyntax.self) })
    else { return nil }

    var parameters: [String] = []
    var assignments: [String] = []
    var replacements: [SyntaxIdentifier: String] = [:]
    var visibility = 2
    for member in members {
      guard let property = member.decl.as(VariableDeclSyntax.self),
            !property.modifiers.contains(where: { ["static", "class"].contains($0.name.text) })
      else { continue }
      guard property.bindings.count == 1, let binding = property.bindings.first
      else { return nil }
      if let accessors = binding.accessorBlock {
        switch accessors.accessors {
        case .getter: continue
        case .accessors(let list):
          if list.contains(where: { ["get", "set", "_read", "_modify"].contains($0.accessorSpecifier.text) }) { continue }
        @unknown default: return nil
        }
      }
      let attributes = property.attributes.compactMap { $0.as(AttributeSyntax.self)?.attributeName.trimmedDescription }
      let wrapper = attributes.first?.split(separator: ".").last.map(String.init)
      if preservingViewInputs, PropertyLayout(property).visibility == 3,
         attributes.count == 1, let wrapper, ["State", "Environment", "EnvironmentObject", "Namespace"].contains(wrapper),
         binding.initializer != nil || wrapper != "State" || PropertyLayout(property).type?.hasPrefix("Optional<") == true
      { continue }
      if preservingViewInputs, attributes.count == 1, wrapper == "Binding", binding.initializer == nil {
        switch (Syntax(binding.pattern).as(SyntaxEnum.self)) {
      case .identifierPattern(let pattern):
        if let type = binding.typeAnnotation?.type {let name = pattern.trimmedDescription
        let qualifier = attributes[0].hasPrefix("SwiftUI.") ? "SwiftUI." : ""
        parameters.append("\(name): \(qualifier)Binding<\(type.trimmedDescription)>")
        assignments.append("  self._\(name) = \(name)")

        visibility = max(visibility, PropertyLayout(property).visibility)

        continue
      }

      default:
        break
      }
      }
      guard property.attributes.isEmpty, let pattern = binding.pattern.as(IdentifierPatternSyntax.self)
      else { return nil }
      if property.bindingSpecifier.text == "let", binding.initializer != nil { continue }
      let layout = PropertyLayout(property)
      guard let type = binding.typeAnnotation?.type.trimmedDescription ?? layout.type else { return nil }
      visibility = max(visibility, layout.visibility)
      let name = pattern.trimmedDescription
      var parameterType = type
      if ({ () -> Bool? in
        switch (Syntax(binding.typeAnnotation?.type)?.as(SyntaxEnum.self)) {
        case .functionType?: return true
        case nil: return nil
        default: return false
        }
      }()) == true {
        parameterType = "@escaping " + type
      }
      var parameter = "\(name): \(parameterType)"
      if let initializer = binding.initializer {
        parameter += " = " + initializer.value.trimmedDescription

        // Assign the parameter once. Keep its default at the parameter boundary.
        let annotation = binding.typeAnnotation == nil ? ": " + type : ""
        let lower = initializer.position.utf8Offset - member.position.utf8Offset
        let upper = initializer.endPosition.utf8Offset - member.position.utf8Offset
        var bytes = Array(member.description.utf8)
        bytes.replaceSubrange(lower..<upper, with: annotation.utf8)
        replacements[member.id] = String(decoding: bytes, as: UTF8.self)
      } else if ({ () -> Bool? in
        switch (Syntax(binding.typeAnnotation?.type)?.as(SyntaxEnum.self)) {
        case .optionalType?: return true
        case nil: return nil
        default: return false
        }
      }()) == true || layout.type?.hasPrefix("Optional<") == true {
        parameter += " = nil"
      }
      parameters.append(parameter)
      assignments.append("  self.\(name) = \(name)")
    }
    guard !parameters.isEmpty || preservingViewInputs else { return nil }
    let access = visibility == 3 ? "private " : visibility == 4 ? "fileprivate " : ""
    source = access
      + "init("
      + parameters.joined(separator: ", ")
      + ") {\n"
      + assignments.joined(separator: "\n")
      + "\n}"
    declarations = replacements
  }
}
