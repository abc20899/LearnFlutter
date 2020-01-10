/*********************************** Dart 编程语言概览  ***********************************/
import 'dart:math';

//////////一个简单的 Dart 程序//////////
// 定义一个函数
void printInteger(int aNumber) {
  print("The number is $aNumber");
}

main() {
  var num = 12;
  printInteger(num); //调用函数

  int lineCount;
  print(lineCount); //null

  const pi = 3.14159;
  const double circle = 2 * pi * 2;
  print(circle);

  var s = 'string interpolation';
  var s2 = 'ss ${s}';
  print(s2);

  var ss1 = 'String concatenation';
  print(ss1 == 'String concatenation');

  var sss1 = '''
you can create
multi-line strings like this one.
''';
  print(sss1);

  ////////// List类型 //////////
  var list = [1, 2, 3]; //推断为 List<int>
  print(list.length);
  print(list[1]);
//在 List 字面量之前添加 const 关键字，可以定义 List 类型的编译时常量
  var constantList = const [1, 2, 3];
//  constantList[1] = 1;  //错误

  ////////// Map类型 //////////
  var gifts = {
    'first': 'apple',
    'second': 'cup',
    'fifth': 'car'
  }; //Map<String,String>

  var weeks = {1: 'Monday', 2: 'Tuesday'}; //Map<int, String>

  //使用Map构造函数创建
  var gifts2 = Map();
  gifts2['11'] = 'AA';
  gifts2['22'] = 'BB';

  var weeks2 = Map();
  weeks2[1] = 'Monday';
  weeks2[2] = 'Tuesday';

  //添加键值对、获取键值对
  gifts2['fourth'] = 'bike';
  var gift1 = gifts2['first'];

  //如果map不包所要查找的key，则返回null
  //length获取长度
  //创建map运行时常量
  final constantMap = const {2: 'Two', 3: 'Three'};

  ////////// 函数类型 //////////
  int sum(int a, int b) {
    return a + b;
  }

  int sum2(int a, int b) => a + b;

  var list1 = [1, 2, 3, 4, 5, 6];
  list1.forEach(printElement);

  var upLitter = (msg) => '!!! ${msg.toUpperCase()} !!!';
  print(upLitter('hello'));

  var list2 = ['apple', 'bananas', 'oranges'];
  list2.forEach((item) {
    print('${list2.indexOf(item)} : ${item}');
  });

  testConstPoint();
  getClassType();
  testSuper();
}

void printElement(int element) {
  print(element);
}

////////// 定义类Class //////////
class Point {
  var x = 0.0;
  var y = 0.0;

  Point(this.x, this.y);

  //命令构造函数
  Point.formJson(Map json) {
    x = json['x'];
    y = json['y'];
  }
}

void testPoint() {
  var p = Point(0, 0);
  p.x = 1.1;
  p?.y = 2.0;

  var p2 = Point.formJson({'x': 1.2, 'y': 2.3});
}

////////// 定义常量构造函数 //////////
class ImmutablePoint {
  //变量定义为final
  final x;
  final y;

  //常量构造函数
  const ImmutablePoint(this.x, this.y);

  static final origin = const ImmutablePoint(0.0, 0.0);
}

void testConstPoint() {
  //创建一个常量对象
  const a = ImmutablePoint(1, 1);
  const b = ImmutablePoint(1, 1);
  print(a == b); //true

  //创建一个非常量对象
  var aa = ImmutablePoint(2, 2);
  var bb = ImmutablePoint(2, 2);
  print(aa == bb); //false
}

////////// 获取类的类型 //////////
void getClassType() {
  var p = Point(0, 0);
  print(p.runtimeType); //Point
}

////////// 如果父类中没有匿名无参的构造函数， 则需要手工调用父类的其他构造函数 //////////
class Person {
  Person.fromJson(Map data) {
    print('in person');
  }
}

class Student extends Person {
  Student.fromJson(Map data) : super.fromJson(data) {
    print('in student');
  }
}

void testSuper() {
  var li = Student.fromJson({});
  //in person
  //in student
}

////////// 在构造函数体执行之前初始化实例变量 //////////
class Point2 {
  num x, y;

  Point2.fromJson(Map data)
      : x = data['x'],
        y = data['y'] {
    print('In Point.fromJson(): ($x, $y)');
  }

  Point2.withAssert(this.x, this.y) : assert(x > 0) {
    print('In Point.withAssert(): ($x, $y)');
  }
}

////////// 使用初始化列表可以很方便的设置 final 字段 //////////
//使用初始化列表可以很方便的设置 final 字段
class Point3 {
  final num x;
  final num y;
  final num distanceFromOrigin;

  Point3(x, y, distanceFromOrigin)
      : x = x,
        y = y,
        distanceFromOrigin = sqrt(x * x + y * y);
}

////////// 重定向构造函数 //////////
class Point4 {
  num x, y;

  //主构造函数
  Point4(this.x, this.y);

  //重定向函数 指向主构造函数
  Point4.alongXAxis(num x) : this(x, 0);
}
