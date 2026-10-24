import SwiftParser
import SwiftSyntax

/// Requires one top-level enum for each diagnostic group. Helper types belong inside these enums.
struct FixtureStructure {
  let syntax: SourceFileSyntax

  init(_ source: String) {
    syntax = Parser.parse(source: source)
  }

  var isValid: Bool {
    Self.groupNames(in: syntax.statements).sorted() == ["Accepted", "Rejected"]
  }

  /// Finds a named case so that its diagnostic count stays independent after groups are combined.
  func lines(for name: String) -> ClosedRange<Int>? {
    let converter = SourceLocationConverter(fileName: "<fixture>", tree: syntax)

    for item in syntax.statements {
      guard let group = item.item.as(EnumDeclSyntax.self) else { continue }

      for member in group.memberBlock.members {
        let memberName: String? = switch member.decl.as(DeclSyntaxEnum.self) {
        case .functionDecl(let function): function.name.text
        case .structDecl(let type): type.name.text
        case .classDecl(let type): type.name.text
        default: nil
        }

        guard let memberName, "\(group.name.text).\(memberName)" == name
        else { continue }

        let start = converter.location(for: member.decl.positionAfterSkippingLeadingTrivia).line
        let end = converter.location(for: member.decl.endPositionBeforeTrailingTrivia).line

        return start...end
      }
    }

    return nil
  }

  private static func groupNames(in items: CodeBlockItemListSyntax) -> [String] {
    items.flatMap { item -> [String] in
      guard let declaration = item.item.as(DeclSyntax.self) else { return [] }

      return switch declaration.as(DeclSyntaxEnum.self) {
      case .enumDecl(let group): [group.name.text]
      case .structDecl, .classDecl, .actorDecl, .protocolDecl, .typeAliasDecl: [""]

      case .ifConfigDecl(let configuration):
        configuration.clauses.flatMap { clause -> [String] in
          guard let branch = clause.elements?.as(CodeBlockItemListSyntax.self) else { return [] }

          return groupNames(in: branch)
        }

      default: []
      }
    }
  }
}
