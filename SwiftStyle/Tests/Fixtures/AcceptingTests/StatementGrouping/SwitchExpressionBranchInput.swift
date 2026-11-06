enum Examples {

  static func label(_ kind: Int, center: Int) -> String {
    let angle = center + 90
    let text = switch kind {
    case 0: String(angle)
    default: "circular \(angle)"
    }
    return text
  }
}
