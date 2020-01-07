/*********************************** Dart 编程语言概览  ***********************************/
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

  var list = [1, 2, 3]; //推断为 List<int>
  print(list.length);
  print(list[1]);
//在 List 字面量之前添加 const 关键字，可以定义 List 类型的编译时常量
  var constantList = const [1, 2, 3];
}
