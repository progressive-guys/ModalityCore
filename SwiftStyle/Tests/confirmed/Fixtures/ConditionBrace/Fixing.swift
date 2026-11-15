// MARK: - Открывающая скобка многострочного if на отдельной строке
func sum(_ first: Int?, _ second: Int?) -> Int {
  if let first,
     let second {
    return first + second
  }

  return 0
}

/// Output
func sum(_ first: Int?, _ second: Int?) -> Int {
  if let first,
    let second
  {
    return first + second
  }

  return 0
}
