public enum Examples {

  struct CompactRequirementsKeepOrder {

    protocol Requirements {
      var b: Int { get set }
      var a: Int { get }
    }
  }
}
