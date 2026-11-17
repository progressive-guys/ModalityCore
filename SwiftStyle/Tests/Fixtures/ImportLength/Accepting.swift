// MARK: - Пустая строка разделяет группы импортов
import Foundation

import Dispatch

// MARK: - Условная компиляция разделяет группы импортов
#if USE_FOUNDATION
import Foundation
#else
import Dispatch
#endif
