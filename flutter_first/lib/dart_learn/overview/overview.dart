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
}

void printElement(int element) {
  print(element);
}
