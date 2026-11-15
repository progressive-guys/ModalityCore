// MARK: - Пустая строка после многострочного getter
struct MissingGapAfterLongGetter {

  var x: Int {
    let n = 1
    return n
  }
  func read() -> Int { x }
}

/// Output
struct MissingGapAfterLongGetter {

  var x: Int {
    let n = 1
    return n
  }

  func read() -> Int { x }
}

// MARK: - Пустая строка между свойствами с многострочными аксессорами
struct MissingGapBetweenAccessors {

  var a: Int {
    get { 1 }
    set {}
  }
  var b: Int {
    get { 2 }
    set {}
  }
}

/// Output
struct MissingGapBetweenAccessors {

  var a: Int {
    get { 1 }
    set {}
  }

  var b: Int {
    get { 2 }
    set {}
  }
}

// MARK: - Пустая строка между let и var ставится перед комментарием к var
struct MissingBindingGapBeforeComment {
  let a = 1
  // Mutable value.
  var b = 2
}

/// Output
struct MissingBindingGapBeforeComment {

  let a = 1

  // Mutable value.
  var b = 2
}

// MARK: - Объявления идут подряд после заголовка группы
struct BlankLineAfterGroupHeader {

  // Input values.
  var a = 1

  var b = 2
}

/// Output
struct BlankLineAfterGroupHeader {
  // Input values.
  var a = 1
  var b = 2
}

// MARK: - Пара коротких вычисляемых свойств идёт подряд
struct ExtraComputedGap {
  var a: Int { 1 }

  var b: Int { 2 }
}

/// Output
struct ExtraComputedGap {

  var a: Int { 1 }
  var b: Int { 2 }
}

// MARK: - Пара коротких свойств разных типов идёт подряд
struct ExtraGapBetweenTwoTypes {

  var w: Double = 1

  var s: String = "value"
}

/// Output
struct ExtraGapBetweenTwoTypes {

  var w: Double = 1
  var s: String = "value"
}

// MARK: - Пара коротких свойств с разными обёртками идёт подряд
enum Wrappers {

  @propertyWrapper
  struct F<Value> {
    var wrappedValue: Value
  }

  @propertyWrapper
  struct G<Value> {
    var wrappedValue: Value
  }
}

struct ExtraGapBetweenTwoWrappers {

  @Wrappers.F var a: Int = 1

  @Wrappers.G var b: Int = 2
}

/// Output
enum Wrappers {

  @propertyWrapper
  struct F<Value> {
    var wrappedValue: Value
  }

  @propertyWrapper
  struct G<Value> {
    var wrappedValue: Value
  }
}

struct ExtraGapBetweenTwoWrappers {

  @Wrappers.F var a: Int = 1
  @Wrappers.G var b: Int = 2
}

// MARK: - Требования свойств с get и get set идут подряд
protocol Values {
  var a: Int { get }

  var b: Int { get set }
}

/// Output
protocol Values {

  var a: Int { get }
  var b: Int { get set }
}

// MARK: - Пара коротких свойств одного типа идёт подряд
struct BlankLineWithinSameType {

  var a = 1

  var b = 2
}

/// Output
struct BlankLineWithinSameType {

  var a = 1
  var b = 2
}

// MARK: - Две пустые строки между свойствами с аксессорами сокращаются до одной
struct ExtraGapBetweenAccessors {

  var a: Int {
    get { 1 }
    set {}
  }


  var b: Int {
    get { 2 }
    set {}
  }
}

/// Output
struct ExtraGapBetweenAccessors {

  var a: Int {
    get { 1 }
    set {}
  }

  var b: Int {
    get { 2 }
    set {}
  }
}

// MARK: - Две пустые строки между let и var сокращаются до одной
struct ExtraBindingGap {
  let a = 1


  var b = 2
}

/// Output
struct ExtraBindingGap {

  let a = 1

  var b = 2
}

// MARK: - Между let и var добавляется пустая строка
struct MissingSmallBindingGap {
  let a = 1
  var b = 2
}

/// Output
struct MissingSmallBindingGap {

  let a = 1

  var b = 2
}

// MARK: - Между let и var с обёрткой добавляется пустая строка
enum Wrappers {

  @propertyWrapper
  struct F<Value> {
    var wrappedValue: Value
  }
}

struct MissingWrapperBindingGap {
  let a = 1
  @Wrappers.F var b = 2
}

/// Output
enum Wrappers {

  @propertyWrapper
  struct F<Value> {
    var wrappedValue: Value
  }
}

struct MissingWrapperBindingGap {

  let a = 1

  @Wrappers.F var b = 2
}

// MARK: - Свойство с литералом на отдельной строке отделяется от предыдущего свойства
class Computed {
  var longerName: Int { 1 }
  var x: Int {
    1000000000000000
  }
}

/// Output
class Computed {

  var longerName: Int { 1 }

  var x: Int {
    1000000000000000
  }
}
