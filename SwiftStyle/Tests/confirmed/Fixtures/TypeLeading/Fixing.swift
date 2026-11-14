// MARK: - Case FourCodeLinesNeedPadding
// MARK: Input
enum Quartet {
  case first
  case second
  case third
  case fourth
}

// MARK: Output
enum Quartet {

  case first
  case second
  case third
  case fourth
}

// MARK: - Case FourCodeLinesNeedPadding
// MARK: Input

// MARK: - Case OneCodeLine
enum Single { case only }


// MARK: Output
enum Quartet {
  case only
}

// MARK: - Case EmptyEnum
// MARK: Input
enum Single {
}


// MARK: Output
enum Single { }
