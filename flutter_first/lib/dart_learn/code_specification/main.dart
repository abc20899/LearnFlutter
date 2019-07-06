import 'dart:math';

void main() {
  ///不需要使用+拼接  使用相邻的字符串字面量定义来链接字符串
  printStr('abcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefg'
      'abcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefg');

  ///使用插值的形式来组合字符串和值
  printPerson('junechiu', 30);

  ///尽可能的使用集合字面量来定义集合。
  ///定义一个空的可变的 list：[] 和 new List()
  ///定义一个空的 linked hash map： {}、 new Map()、 和 new LinkedHashMap()
  var points = [];
  var address = {};
  var persons = <Person>[];
  var addressMap = <Address>{};

  ///不要 使用 .length 来判断集合是否为空
  ///Dart 提供了更加高效率和易用的 getter 函数： .isEmpty 和.isNotEmpty
  var numArr = [1, 2, 3, 4, 5, 6];
  if (numArr.isEmpty) {
    print('empty');
  } else {
    numArr.forEach((num) => print('num: $num'));
    numArr.forEach(print); //print方法的参数与forEach值
  }

  ///使用高阶（higher-order）函数来转换集合数据。
  ///使用 .map()、 .where() 以及 Iterable 提供的其他函数
  var animals = <Animal>[];
  animals.add(Animal('dog', false));
  animals.add(Animal('fish', true));
  animals.add(Animal('cat', false));
  animals.add(Animal('dolphin', true));
  var aquaticNames =
      animals.where((animal) => animal.isAquatic).map((animal) => animal.name);
  print(aquaticNames);
}

void printStr(String str) {
  print(str);
}

void printPerson(String name, int age) => print('I am $name and age is $age');

class Person {}

class Address {}

class Animal {
  final String name;
  final bool isAquatic;

  Animal(this.name, this.isAquatic) {}
}

///避免 保存可以计算的结果
class Circle {
  num radius;

  num get area => pi * radius * radius;

  num get circumference => pi * 2.0 * radius;

  Circle(this.radius);
}

///省略局部变量的类型
///var peopleByZip = <int, List<Person>>{};

///要 用 ; 来替代空函数体的构造函数 {}
class Point {
  int x, y;

  Point(this.x, this.y);
}
