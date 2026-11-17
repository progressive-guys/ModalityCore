// MARK: - В условной ветке свойство public перемещается перед private
public enum Examples {

  struct WrongVisibilityInConditionalBranch {

    #if PROPERTY_BRANCH
    private var a = 1
    public var b = 2
    #endif
  }
}

/// Output
public enum Examples {

  struct WrongVisibilityInConditionalBranch {

    #if PROPERTY_BRANCH
    public var b = 2
    private var a = 1
    #endif
  }
}

// MARK: - Свойства с вызовом конструктора одного типа группируются вместе
struct RepeatedConstructorTypeGroup {
  let a = String("one")
  let m = 1
  let z = String("two")
}

/// Output
struct RepeatedConstructorTypeGroup {

  let m = 1
  let a = String("one")
  let z = String("two")
}

// MARK: - Четыре привязки в одном объявлении отделяются от свойства экземпляра
struct MultipleBindingsCountTowardGroupSize {

  static let a = 1, b = 2, c = 3, cc = 4
  let d = 4
}

/// Output
struct MultipleBindingsCountTowardGroupSize {

  static let a = 1, b = 2, c = 3, cc = 4

  let d = 4
}

// MARK: - Четыре статических свойства отделяются от свойства экземпляра
struct MissingStaticGroupGap {

  static let a = 1
  static let b = 2
  static let c = 3
  static let cc = 4
  let d = 4
}

/// Output
struct MissingStaticGroupGap {

  static let a = 1
  static let b = 2
  static let c = 3
  static let cc = 4

  let d = 4
}

// MARK: - Четыре свойства public отделяются от private пустой строкой
struct MissingVisibilityGroupGap {

  public var a = 1
  public var b = 2
  public var c = 3
  public var cc = 4
  private var d = 4
}

/// Output
struct MissingVisibilityGroupGap {

  public var a = 1
  public var b = 2
  public var c = 3
  public var cc = 4

  private var d = 4
}

// MARK: - Константы перед изменяемыми свойствами
final class Values {
  var a = 1
  let b = 2
}

/// Output
final class Values {

  let b = 2

  var a = 1
}

// MARK: - Обычные хранимые свойства перед свойствами с обёртками
enum Wrappers {

  @propertyWrapper
  struct F<Value> {
    var wrappedValue: Value
  }
}

final class Values {
  @Wrappers.F var a: Int = 1
  var b = 2
}

/// Output
enum Wrappers {

  @propertyWrapper
  struct F<Value> {
    var wrappedValue: Value
  }
}

final class Values {

  var b = 2
  @Wrappers.F var a: Int = 1
}

// MARK: - Свойства private перед fileprivate
final class Values {
  fileprivate var a = 1
  private var b = 2
}

/// Output
final class Values {

  private var b = 2
  fileprivate var a = 1
}

// MARK: - Свойства public перед private
final class Values {
  private var a = 1
  public var b = 2
}

/// Output
final class Values {

  public var b = 2
  private var a = 1
}

// MARK: - Свойство Published с открытым setter размещается перед private(set)

final class Model {

  @Published private(set) var value = 0
  @Published var isReady = false
}

/// Output

final class Model {

  @Published var isReady = false

  @Published private(set) var value = 0
}

// MARK: - Свойства с одинаковым явным типом собираются вместе
final class Values {
  var a: Int = 1
  var m: String = "value"
  var z: Int = 2
}

/// Output
final class Values {

  var a: Int = 1
  var z: Int = 2
  var m: String = "value"
}

// MARK: - Свойства с целочисленными литералами собираются вместе
final class Values {
  var a = 1
  var m = "value"
  var z = -2
}

/// Output
final class Values {

  var a = 1
  var z = -2
  var m = "value"
}

// MARK: - Свойства с одинаковой обёрткой собираются вместе
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

// MARK: - Свойства с одинаковой обёрткой собираются вместе
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

struct RepeatedWrapperGroup {
  @Wrappers.F var a: Int = 1
  @Wrappers.G var m: Int = 2
  @Wrappers.F var z: Int = 3

  init() { }
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

struct RepeatedWrapperGroup {

  @Wrappers.F var a: Int = 1
  @Wrappers.F var z: Int = 3
  @Wrappers.G var m: Int = 2

  init() { }
}
struct RepeatedWrapperGroup {
  @Wrappers.F var a: Int = 1
  @Wrappers.G var m: Int = 2
  @Wrappers.F var z: Int = 3

  init() { }
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

struct RepeatedWrapperGroup {

  @Wrappers.F var a: Int = 1
  @Wrappers.F var z: Int = 3
  @Wrappers.G var m: Int = 2

  init() { }
}

// MARK: - Свойство Int присоединяется к объявлению с общей аннотацией Int
struct RepeatedSharedTypeGroup {
  var a, b: Int
  var s = "value"
  var z = 3

  init(a: Int, b: Int) {
    self.a = a
    self.b = b
  }
}

/// Output
struct RepeatedSharedTypeGroup {

  var z = 3
  var a, b: Int
  var s = "value"

  init(a: Int, b: Int) {
    self.a = a
    self.b = b
  }
}

// MARK: - Статические свойства перед свойствами экземпляра
final class Values {
  let a = 1
  static let b = 2
}

/// Output
final class Values {

  static let b = 2
  let a = 1
}
