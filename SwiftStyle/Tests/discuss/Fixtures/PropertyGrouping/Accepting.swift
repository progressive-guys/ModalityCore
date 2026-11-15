// MARK: - Разные формы записи типа массива
struct EquivalentArrayTypeSpellings {

  var a: [Int]
  var m : String
  var b: Array<Int>

  init(a: [Int] = [], b: Array<Int> = [], m: String = "value") {
    self.a = a
    self.b = b
    self.m = m
  }
}

// MARK: - Вычисляемые свойства с разным доступом имеют многострочные тела
public enum Examples {

  struct ComputedCommentGroups {

    private var longerName: Int {
      1
    }

    var second: Int {
      2
    }

    var third: Int {
      3
    }

    var fourth: Int {
      4
    }

    public static var flag: Bool {
      true
    }
  }
}

// MARK: - Комментарии перед многострочными вычисляемыми свойствами сохраняются
public enum Examples {

  struct ComputedCommentGroups {

    // Display values.
    var title: String {
      "value"
    }

    var x: Int {
      0
    }
  }
}

// MARK: - Эффективный уровень доступа в расширении
public enum Examples { }

public extension Examples {

  var a1: Int {
    1
  }

  internal var b1: Int {
    2
  }
}

// MARK: - Большая группа отделяется пустой строкой с обеих сторон
struct LargeGroupHasBothSeparators {

  let value = 0

  var a = 1
  var b = 2
  var c = 3
  var d = 4

  private var hidden = 5
}

// MARK: - Заголовок MARK группы сохраняется
struct HeaderBetweenVisibilityGroups {

  public var a = 1
  public var b = 2
  public var c = 3
  public var cc = 4

  // MARK: - Private values

  private var d = 4
  private var e = 5
}

// MARK: - Свойства разделены по доступу для записи при одинаковом доступе для чтения
struct ReadVisibilityWithPrivateSetter {

  public var b : Int

  public private(set) var a : Int
  var c : Int

  init(a: Int = 1, b: Int = 2, c: Int = 3) {
    self.a = a
    self.b = b
    self.c = c
  }
}

// MARK: - Хранимые свойства упорядочены по доступу, вычисляемое open размещено после них
open class ReadVisibilityOrder {

  public var b = 2
  var c = 3
  private var d = 4
  fileprivate var e = 5

  open var a: Int {
    1
  }
}

// MARK: - Общая аннотация типа у нескольких свойств
struct SharedTypeAnnotation {

  var c = 3
  var a, b: Int
  var s = "value"
}

// MARK: - Перекрёстные ссылки между статическими свойствами
struct OptionSetLiteralKeepsDeclaredType: OptionSet {

  static let c: OptionSetLiteralKeepsDeclaredType = [.a, .b]
  static let a = OptionSetLiteralKeepsDeclaredType(rawValue: 1)
  static let b = OptionSetLiteralKeepsDeclaredType(rawValue: 2)
  let rawValue: Int

  init(rawValue: Int) {
    self.rawValue = rawValue
  }
}

// MARK: - Группа из трёх статических свойств
struct ThreeElementsStayTogether {

  static let a = 1
  static let b = 2
  static let c = 3
  let value = 4
}

// MARK: - Результаты обычного вызова не группируются по выведенному типу
private func makeNumber() -> Int {
  1
}

struct Values {

  let a = makeNumber()
  let z = makeNumber()
  let m = "value"
}

// MARK: - Аргументы одной обёртки не разделяют её на разные виды
@propertyWrapper
struct Wrapped<Value> {
  var wrappedValue: Value
}

struct Values {

  @Wrapped(wrappedValue: 1) var a: Int
  @Wrapped(wrappedValue: 2) var b: Int
}
