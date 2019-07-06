import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'package:english_words/english_words.dart';

//一、变量声明
//1、var一种不指定类型声明变量的方式，也可以指定变量类型。
//2、没有初始化的变量自动获取一个默认值为 null。类型为数字的 变量如何没有初始化其值也是 null，不要忘记了 数字类型也是对象。
var name = 'junechiu';
var year = 1988;
var pi = 3.14;
var arr = ['c', 'c++', 'zx', 'ss', 1.2];
var img = {
  'tags': ['staturn'],
  'url': '//path/to/img/sss.jpg'
};
//3、在声明变量的时候，你可以选择加上具体类型，局部变量使用var来定义
String name2 = 'junechiu';
//4、使用final或者const。
/**
    一个final变量只能赋值一次；一个const变量是编译时常量。
    (Const变量同时也是final变量。）顶级的final变量或者类中的final变量在第一次使用的时候初始化。
    实例变量可以为final但是不能是const
    const变量在类中，请定义为 static const
 */
final name3 = 'Bob';
final String name4 = 'june';
const int count = 1;
//5、类似于JavaScript中的var，它可以接收任何类型的变量，但最大的不同是Dart中var变量一旦赋值，类型便会确定，则不能再改变其类型
var t1 = "hi world";
//t1 = 200;

//6、
/**
    Object 是Dart所有对象的根基类，也就是说所有类型都是Object的子类(包括Function和Null)，所以任何类型的数据都可以赋值给Object声明的对象.
    dynamic与var一样都是关键词,声明的变量可以赋值任意对象。 而dynamic与Object相同之处在于,他们声明的变量可以在后期改变赋值类型。
    dynamic与Object不同的是,dynamic声明的对象编译器会提供所有可能的组合, 而Object声明的对象只能使用Object的属性与方法, 否则编译器会报错。
 */
void test2() {
  dynamic t;
  Object x;
  t = "hi world";
  x = 'Hello Object';
//下面代码没有问题
  t = 1000;
  x = 1000;
}

void test3() {
  //dynamic的这个特性与Objective-C中的id作用很像. dynamic的这个特点使得我们在使用它时需要格外注意,这很容易引入一个运行时错误.
  dynamic a;
  Object b;
  a = "";
  b = "";
  print(a.length);
//  print(b.length);// 变量b编译器会报错 The getter 'length' is not defined for the class 'Object'
}

//7、内置的类型
/**
    numbers  --> int  double
    strings  --> 'abc'  "abc"    == 操作符判断两个对象的内容是否一样
    booleans  --> bool类型 true false  只有true对象才被认为是true。 所有其他的值都是flase
    lists (也被称之为 arrays)   数组就是List对象
    maps  键和值可以是任何类型的对象
    runes (用于在字符串中表示Unicode字符)
    symbols
 */
var x = 1;
var y = 1.34;

var one = int.parse('1'); //string => int
var onePone = double.parse('1.1'); //string => double
String oneAsString = 1.toString(); //int => string
String piAsString = 3.14.toStringAsFixed(2); //double => string

//可以使用 + 操作符来把多个字符串链接为一个，也可以把多个 字符串放到一起来实现同样的功能
var s5 = 's' '5s';
var s6 = 'ssss' + "666";

//使用三个单引号或者双引号也可以 创建多行字符串对象
var s1 = '''
You can create
multi-line strings like this one.
''';
var s2 = """This is also a
multi-line string.""";

void test5() {
  var nameT = 'Bob'; //nameT != true
//  if (nameT) {  //在 Dart 检查模式运行，代码将会抛出一个异常，表示name变量不是一个布尔值。
  // Prints in JavaScript, not in Dart.
//    print('You have a name!');
//  }
}

void testList() {
  var list = [1, 2, 3];
  list[1] = 1;
  //一个不变的list对象
  var finalList = const [1, 2, 3];
  print(list.length);
}

void testMap() {
  var gifts = {'A': 'car', 'B': 'phone', 'C': 'cup'};

  var cate = new Map();
  cate['a'] = 'aa';
  cate['b'] = 'bbb';
  cate['c'] = 'vvv';

  var constMap = const {1: 'a', 2: 'b', 3: 'c'};

  print(cate.length);
}

/************************************************************************************************************/
//二、Functions（方法）
//1、方法也是对象并且具有一种类型Function。这意味着，方法可以赋值给变量，也可以当做其他方法的参数。 也可以把 Dart 类的实例当做方法来调用
bool isPhoneNum(String num) {
  return num.length == 11;
}

//2、对于只有一个表达式的方法，可以使用缩写语法来定义
bool isPhoneNum2(String num) => num.length == 11;

//3、可选参数  可选命名{param1, param2, …} 和 可选位置(参数放到 [] 中就变成可选位置参数)
enableFlags({bool bold, bool hidden}) {}

void testF() {
  enableFlags(bold: true, hidden: false);
  enableFlags(bold: true);
}

String say(String from, String msg, [String device]) {
  var result = '$from say $msg';
  if (device != null) {
    result = '$from say $msg with a $device';
  }
  return result;
}

void testff() {
  say('Bob', 'hello'); //不使用可选参数调用
  say('Bob', 'hello', 'smoke signal'); //使用可选参数调用
}

//4、默认参数值  使用=设置
double area({int width = 4, int height = 2}) {
  return (width * height).floorToDouble();
}

void testf3() {
  print(area());
}

//5、list map作为参数设置默认值
void doStuff(
    {List<int> list = const [1, 2, 3],
    Map<String, String> map = const {'a': 'apple'}}) {
  print('list = $list');
  print('map = $map');
}

//6、main() function（入口函数）
//每个应用都需要有个顶级的 main() 入口方法才能执行。 main() 方法的返回值为 void 并且有个可选的 List<String> 参数。

//7、Functions as first-class objects（一等方法对象）
printElement(element) {
  print(element);
}

var elements = [1, 2, 3];

void testf6() {
  elements.forEach(printElement); //forEach (int) -> void f   printElement方法当做参数
}

//8、函数作为变量
var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';

void testf7() {
  print(loudify('hello'));
}

//9、Anonymous functions（匿名方法）
var listFruit = ['apples', 'oranges', 'grapes', 'bananas', 'plums'];

void testf8() {
  listFruit.forEach((i) {
    print('${listFruit.indexOf(i)} : $i');
  });
  listFruit.forEach((i) => print('${listFruit.indexOf(i)} : $i'));
}

//10、Lexical closures（词法闭包）
Function makeAdder(num addBy) {
  return (num i) => addBy + i; //返回一个函数类型
}

void testf9() {
  var add2 = makeAdder(2);
  print(add2(3));
}

//11、测试函数是否相等
foo() {}

class A {
  static void bar() {}

  void baz() {}
}

void testf10() {
  var x;
  x = foo;
  print(foo == x); //true

  x = A.bar;
  print(A.bar == x); //true

  var v = new A();
  var w = new A();
  var y = w;
  x = w.baz;
  print(y.baz == x);
  print(v.baz == w.baz);
}

//12、所有的函数都返回一个值。如果没有指定返回值，则 默认把语句 return null; 作为函数的最后一个语句执行。

/************************************************************************************************************/
//三、操作符
//1、类型判定
// as	  类型转换
// is	  如果对象是指定的类型返回 True
// is!	如果对象是指定的类型返回 False
//只有当 obj 实现了 T 的接口， obj is T 才是 true。例如 obj is Object 总是 true。
//使用 as 操作符把对象转换为特定的类型。 一般情况下，你可以把它当做用 is 判定类型然后调用 所判定对象的函数的缩写形式

//2、Cascade notation (..)（级联操作符）
//级联操作符 (..) 可以在同一个对象上 连续调用多个函数以及访问成员变量。 使用级联操作符可以避免创建 临时变量， 并且写出来的代码看起来 更加流畅：
/**
 * querySelector('#button')    // Get an object.
    ..text = 'Confirm'         // Use its members.
    ..classes.add('important')
    ..onClick.listen((e) => window.alert('Confirmed!'));
 * */
class B {
  var x = 1;

  void printInfo() {
    print('x = $x');
  }
}

void teste1() {
  B()
    ..x = 10
    ..printInfo();
}

//3、?.   左边的操作对象不能为 null，例如 foo?.bar 如果 foo 为 null 则返回 null，否则返回 bar 成员

/************************************************************************************************************/

//四、流程控制
/**
    if and else
    for loops
    while and do-while loops
    break and continue
    switch and case
    assert
 */
void test() {
  if (year >= 2001) {
    print('21st');
  } else {
    print('20th');
  }

  for (var obj in arr) {
    print(obj);
  }

  for (int month = 1; month <= 12; month++) {
    print('$month');
  }

  while (year < 2016) {
    year += 1;
  }
}

/************************************************************************************************************/

//五、Exceptions（异常）
//1、Throw    throw new FormatException('Expected at least 1 section');
//   还可以抛出任意的对象： throw 'Out of llamas!';
/**
    distanceTo(Point other) =>
    throw new UnimplementedError();
 */
//2、Catch  可以使用on 或者 catch 来声明捕获语句，也可以 同时使用
/**
    try {
    breedMoreLlamas();
    } on OutOfLlamasException {
    buyMoreLlamas();
    } on Exception catch (e) {
    print('Unknown exception: $e');
    } catch (e) {
    print('Something really unknown: $e');
    }
 */
//3、Finally  要确保某些代码执行，不管有没有出现异常都需要执行，可以使用 一个 finally 语句来实现
/**
    try {
    breedMoreLlamas();
    } finally {
    cleanLlamaStalls();
    }
 */

/************************************************************************************************************/

//六、Classes 类 支持基于 mixin 的继承机制 所有的类都继承于 Object
class Point {
  int x;
  int y;

  Point(this.x, this.y);

  //命令构造函数
  Point.fromJson(Map json) {
    x = json['x'];
    y = json['y'];
  }
}

var jsonData = json.decode('{"x":10,"y":12}');

void testc() {
  print(jsonData);
  var p2 = new Point.fromJson(jsonData);
}
//Default constructors（默认构造函数）
//如果你没有定义构造函数，则会有个默认构造函数。 默认构造函数没有参数，并且会调用超类的 没有参数的构造函数。
//Constructors aren’t inherited（构造函数不会继承）
//子类不会继承超类的构造函数。 子类如果没有定义构造函数，则只有一个默认构造函数 （没有名字没有参数）。
//Named constructors（命名构造函数）
//使用命名构造函数可以为一个类实现多个构造函数， 或者使用命名构造函数来更清晰的表明你的意图

//构造函数不能继承，所以超类的命名构造函数 也不会被继承。如果你希望 子类也有超类一样的命名构造函数， 你必须在子类中自己实现该构造函数。
/**
 * 构造函数执行顺序：
    initializer list（初始化参数列表）
    superclass’s no-arg constructor（超类的无名构造函数）
    main class’s no-arg constructor（主类的无名构造函数）
 * */

//子类调用超类的命名构造函数
class Person3 {
  String firstName;

  Person3.fromJson(Map data) {
    print('in person');
  }
}

class Student extends Person3 {
  Student.fromJson(Map data) : super.fromJson(data) {
    print('in Student');
  }
}

void testc1() {
  var st = new Student.fromJson({});
}

//Initializer list（初始化列表）
class Point2 {
  final num x;
  final num y;
  final num distanceFromOrigin;

  Point2(x, y)
      : x = x,
        y = y,
        distanceFromOrigin = sqrt(x * x + y * y) {}
}

testc2() {
  var p = new Point2(1, 2);
  print(p.distanceFromOrigin);
}

//Redirecting constructors（重定向构造函数） 一个构造函数会调动类中的其他构造函数
class Point3 {
  num x;
  num y;

  Point3(this.x, this.y);

  Point3.alongXAxis(num x) : this(x, 0);
}

//Constant constructors（常量构造函数）
//如果你的类提供一个状态不变的对象，你可以把这些对象 定义为编译时常量。要实现这个功能，需要定义一个 const 构造函数，
// 并且声明所有类的变量为 final。
class ImmutablePoint {
  final num x;
  final num y;

  const ImmutablePoint(this.x, this.y);

  static final ImmutablePoint origin = const ImmutablePoint(0, 0);
}

//Factory constructors（工厂方法构造函数）
//如果一个构造函数并不总是返回一个新的对象，则使用 factory 来定义 这个构造函数
class Logger {
  final String name;
  bool mute = false;

  static final Map<String, Logger> _cache = <String, Logger>{};

  factory Logger(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name];
    } else {
      final logger = new Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
  }

  Logger._internal(this.name);

  void log(msg) {
    if (!mute) {
      print(msg);
    }
  }
}

void testc4() {
  var logger = new Logger('UI');
  logger.log('Button clicked');
}

//Getters and setters
//Getters 和 setters 是用来设置和访问对象属性的特殊 函数。每个实例变量都隐含的具有一个 getter， 如果变量不是 final 的则还有一个 setter。
class Rectangle {
  num left;
  num width;
  num top;
  num height;

  num get right => left + width;

  set right(num value) => left = value - width;

  num get bottom => top + height;

  set bottom(num value) => top = value - height;
}

//Abstract methods（抽象函数）
abstract class Doer {
  void dosomething();
}

class EffectiveDoer extends Doer {
  @override
  void dosomething() {}
}

//Abstract classes（抽象类） 如果你希望你的抽象类 是可示例化的，则定义一个 工厂 构造函数。
//子类可以覆写实例函数
//还可以使用 @override 注解来 表明你的函数是想覆写超类的一个函数：
//Enumerated types（枚举类型）
enum Color { red, green, blue }

//Adding features to a class: mixins（为类添加新的功能）
//class Musician extends Performer with Musical {
//}

//Class variables and methods（类变量和函数）

/************************************************************************************************************/

//七、Generics（泛型）
abstract class Cache<T> {
  T getByKey(String key);

  setByKey(String key, T value);
}

//Using collection literals（使用集合字面量）
//List 和 map 字面量也是可以参数化的。 参数化定义 list 需要在中括号之前 添加 <type> ，
// 定义 map 需要在大括号之前 添加 <keyType, valueType>。
var names = <String>['Seth', 'Kathy', 'Lars'];
var pages = <String, String>{
  'index.html': 'Homepage',
  'robots.txt': 'Hints for web robots',
  'humans.txt': 'We are people, not machines'
};

//Using generic methods（使用泛型函数）
T first<T>(List<T> ts) {
//  T tmp ?= ts[0];
//  return tmp;
}

/************************************************************************************************************/

//八、Libraries and visibility（库和可见性）
//库可以使用 Dart package 工具部署
//使用 import 来指定一个库如何使用另外 一个库。  import 'dart:html';
//import 'dart:io';
//import 'package:mylib/mylib.dart';
//import 'package:utils/utils.dart';

//Specifying a library prefix（指定库前缀）
//如果你导入的两个库具有冲突的标识符， 则你可以使用库的前缀来区分。 例如，如果 library1 和 library2 都有一个名字为 Element 的类，
// 你可以这样使用：
/**
 * import 'package:lib1/lib1.dart';
 * import 'package:lib2/lib2.dart' as lib2;
 * Element element1 = new Element();           // Uses Element from lib1.
 * lib2.Element element2 = new lib2.Element(); // Uses Element from lib2.
 * */

//Importing only part of a library（导入库的一部分）
// Import only foo.
//import 'package:lib1/lib1.dart' show foo;
// Import all names EXCEPT foo.
//import 'package:lib2/lib2.dart' hide foo;

//Lazily loading a library（延迟载入库）
//import 'package:deferred/hello.dart' deferred as hello;
/** 当需要使用的时候，使用库标识符调用 loadLibrary() 函数来加载库：
 * greet() async {
    await hello.loadLibrary();
    hello.printGreeting();
    }
 * */

/************************************************************************************************************/

//九、Asynchrony support（异步支持）
//Dart 有一些语言特性来支持 异步编程。 最常见的特性是 async 方法和 await 表达式。Dart 库中有很多返回 Future 或者 Stream 对象的方法。
//使用 async 和 await 的代码是异步的， 但是看起来有点像同步代码
//要使用 await，其方法必须带有 async 关键字：

//Declaring async functions（声明异步方法） 一个 async 方法 是函数体被标记为 async 的方法,
// 在一个方法上添加 async 关键字，则这个方法返回值为 Future
checkVersion() async {}

String lookUpVersionSync() => '1.0.0'; //同步方法

Future<String> lookUpVersion2() async => '1.0.0'; //异步方法

//Using await expressions with Futures（使用 await 表达式） 在一个异步方法内可以使用多次 await 表达式
/**
 *  var entrypoint = await findEntrypoint();
    var exitCode = await runExecutable(entrypoint, args);
    await flushThenExit(exitCode);
 * */
//在 await expression 中， expression 的返回值通常是一个 Future； 如果返回的值不是 Future，则 Dart 会自动把该值放到 Future 中返回。

//Using asynchronous for loops with Streams（在循环中使用异步）
/**
 * await for (variable declaration in expression) {
    // Executes each time the stream emits a value.
    }
 * */

/************************************************************************************************************/

//十、Callable classes（可调用的类）
//如果一个Dart 类实现了 call() 函数则 可以当做方法来调用。
class WannabeFunction {
  call(String a, String b, String c) => '$a $b $c';
}

testc5() {
  var wf = WannabeFunction();
  var out = wf('a', 'b', 'c');
  print('$out');
}

//typedef int Compare(int a, int b);

/************************************************************************************************************/

//3、函数  只有一个语句的方法可以使用缩写 (胖箭头) 语法来定义方法。 特别是当把方法作为函数参数来使用的时候
//main() => print("Hello World!");
int fibonacci(int n) {
  if (n == 0 || n == 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

void test4() {
//  arr.where((name) => name.contains('anus')).forEach(print);
}

//4、class类
class Spacecraft {
  String name;
  DateTime launchDate;
  int launchYear;

  //构造方法
  Spacecraft(this.name, this.launchDate) {
    launchYear = launchDate?.year; //类型安全
  }

  // Named constructor that forwards to the default one.
  Spacecraft.unlaunched(String name) : this(name, null);

  void describe() {
    print('Spacecraft: $name');
    if (launchDate != null) {
      int years = new DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched: $launchYear ($years years ago)');
    } else {
      print('Unlaunched');
    }
  }
}

//5、继承  单继承
class Orbiter extends Spacecraft {
  num altitude;

  Orbiter(String name, DateTime launchDate, this.altitude)
      : super(name, launchDate);
}

//6、Mixins 是在多类继承体系中重用代码的一种方式,相当于一个扩展
class Manned {
  int astronauts;

  void describeCrew() {
    print('Number of astronauts: $astronauts');
  }
}

//Orbiter2类现在也有一个 astronauts 变量和 describeCrew() 函数
class Orbiter2 extends Spacecraft with Manned {
  Orbiter2(String name, DateTime launchDate) : super(name, launchDate);
}

//7、Dart 没有 interface 关键字。在 Dart 中所有的类都隐含的定义了一个接口。因此你可以使用 implement 来实现任意的类隐含定义的接口。
//每个类都隐式的定义了一个包含所有实例成员的接口， 并且这个类实现了这个接口。如果你想 创建类 A 来支持 类 B 的 api，
// 而不想继承 B 的实现， 则类 A 应该实现 B 的接口。
//一个类可以通过 implements 关键字来实现一个或者多个接口， 并实现每个接口定义的 API。
class MockSpaceship implements Spacecraft {
  DateTime launchDate;
  int launchYear;
  String name;

  void describe() {}
}

//隐式接口 greet
class Person {
  //只能在这个库中可见
  final _name;

  Person(this._name);

  //在接口中
  String greet(who) => 'Hello $who,i am $_name.';
}

class Imposter implements Person {
  //必须定义但不使用
  final _name = '';

  String greet(who) => 'Hi $who. Do you know who I am?';
}

greetBob(Person person) => person.greet('bob');

//8、抽象类。抽象类可以包含抽象函数（没有函数体的函数）。
abstract class Describable {
  void describe();

  void describeWithEmphasis() {
    print('======');
    describe();
    print('======');
  }
}

//9、Async异步  使用 async 和 await 可以避免回调接口嵌套的问题，让异步代码更加简洁。
Future<Null> printWithDelay(String message) async {
  await new Future.delayed(const Duration(seconds: 1));
  print(message);
}

Future<Null> printWithDelay2(String message) {
  return new Future.delayed(const Duration(seconds: 1)).then((_) {
    print(message);
  });
}

//async 和 await如何让异步代码变得 更加简单易读
Future<Null> createDescriptions(Iterable<String> objects) async {
  for (var object in objects) {
    try {
      var file = new File('$object.txt');
      if (await file.exists()) {
        var modified = await file.lastModified();
        print('File for $object already exists. It was modified on $modified.');
        continue;
      }
      await file.create();
      await file.writeAsString('Start describing $object in this file.');
    } on IOException catch (e) {
      print('Cannot create description for $object: $e');
    }
  }
}

//10、Exceptions异常
//11、Getters and setters  getter 和setter 是 Dart 中特殊的函数，看起来像是变量
class Spacecraft3 {
  // ...
  DateTime launchDate;

  int get launchYear => launchDate?.year;
// ...
}

void testArr1(){
  const loadingTag = "##loading##"; //表尾标记
  var _words = <String>[loadingTag];
  _words.insertAll(
      _words.length - 1,
      //每次生成20个单词
      generateWordPairs().take(20).map((e) => e.asPascalCase).toList());//转换为list

  print(_words); // loadingTag 会添加到表尾
}

void main() {
  print('Hello World!');
  print(img.values);
  test();
  print(fibonacci(20));

  //实例化类对象
  var voyager = new Spacecraft('Voyager I', new DateTime(1977, 9, 5));
  voyager.describe();

  var voyager3 = new Spacecraft.unlaunched('Voyager III');
  voyager3.describe();

  print(greetBob(new Person('kathy')));
  print(greetBob(new Imposter()));

  printWithDelay2("ssddd");

  int lineCount; //默认值null
  print(lineCount);
  assert(lineCount == null);

  testf3();
  doStuff();
  testf7();
  testf8();
  testf9();
  testf10();

  teste1();
  testc();
  testc2();
  testc4();
  testc5();
  testArr1();

  List<dynamic> list = json.decode('["国产剧"]');
  print(list[0]);
}

/**
 * 1、所有能够使用变量引用的都是对象， 每个对象都是一个类的实例。在 Dart 中 甚至连 数字、方法和 null 都是对象。所有的对象都继承于 Object 类。
 * 2、使用静态类型(例如前面示例中的 num ) 可以更清晰的表明你的意图，并且可以让静态分析工具来分析你的代码，没有指定类型的变量的类型为 dynamic
 * 3、Dart 在运行之前会先解析你的代码。你可以通过使用 类型或者编译时常量来帮助 Dart 去捕获异常以及 让代码运行的更高效。
 * 4、Dart 支持顶级方法 (例如 main())，同时还支持在类中定义函数。 （静态函数和实例函数）。 你还可以在方法中定义方法 （嵌套方法或者局部方法）。
 * 5、同样，Dart 还支持顶级变量，以及 在类中定义变量（静态变量和实例变量）。 实例变量有时候被称之为域（Fields）或者属性（Properties）。
 * 6、和 Java 不同的是，Dart 没有 public、 protected、 和 private 关键字。如果一个标识符以 (_) 开头，则该标识符 在库内是私有的。
 * 7、
 *
 * */
