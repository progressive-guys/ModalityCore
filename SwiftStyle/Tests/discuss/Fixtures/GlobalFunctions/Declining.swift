// MARK: - Глобальная функция внутри условной компиляции требует ручного решения
#if os(macOS)
@MainActor
func example() { }
#endif
