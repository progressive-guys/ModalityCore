// MARK: - Импорты без аннотаций размещаются перед импортами с preconcurrency
@preconcurrency import Dispatch
@preconcurrency import AnotherDispatch
import Foundation
import VeryVeryLongImportFoundation

/// Output
import Foundation
import VeryVeryLongImportFoundation
@preconcurrency import Dispatch
@preconcurrency import AnotherDispatch

// MARK: - Сортировка импортов разной длины
import Foundation
import Dispatch
import Swift

/// Output
import Swift
import Dispatch
import Foundation

// MARK: - Комментарий перемещается вместе с импортом
import Foundation
// Needed by the following import.
import Dispatch

/// Output
// Needed by the following import.
import Dispatch
import Foundation
