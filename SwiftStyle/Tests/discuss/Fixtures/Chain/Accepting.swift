// MARK: - Продолжение цепочки после однострочного основания
func adjusted(_ values: [Int]) -> [Int] {
  values.map { $0 + 1 }
    .filter { $0 > 0 }
}
