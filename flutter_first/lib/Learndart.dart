//1、变量 这里没有显式的指定变量类型。也可以指定变量类型。
var name = 'junechiu';
var year = 1988;
var pi = 3.14;
var arr = ['c', 'c++', 'zx', 'ss', 1.2];
var img = {
  'tags': ['staturn'],
  'url': '//path/to/img/sss.jpg'
};

//2、流程控制
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

//3、函数  只有一个语句的方法可以使用缩写 (胖箭头) 语法来定义方法。 特别是当把方法作为函数参数来使用的时候
//main() => print("Hello World!");
int fibonacci(int n) {
  if (n == 0 || n == 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

void test2() {
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


//10、Exceptions异常



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
}
