### dart文档
[中文文档](https://www.dartcn.com/guides/language/language-tour)

### 重要的概念
* 变量即对象，并对应一个类的实例，数字，函数和 null 都是对象。所有对象继承自 Object 类
* 尽管 Dart 是强类型的，但是 Dart 可以推断类型
* Dart 支持泛型，如 List <int> （整数列表）或 List <dynamic> （任何类型的对象列表）
* Dart支持顶级函数，静态函数和实例函数、嵌套或局部函数 
* Dart支持顶级变量，静态变量和实例变量
* 条件表达式 condition ? expr1 : expr2 的值可能是 expr1 或 expr2 

### 变量
变量仅存储对象引用

```
//不需要指定变量类型
var name = 'Bob';
//对象不限定为单个类型，可以指定为对象类型或动态类型
dynamic name = 'Bob';
//显式声明可以推断出的类型
String name = 'David';
```

##### 默认值
未初始化的变量默认值是null。 Dart中一切都是对象，数字类型也不例外。

```
int lineCount;
print(lineCount); //null
```
##### Final 和 Const
从来不会被修改的变量,可以使用final或const,Final 变量的值只能被设置一次；Const变量在编译时就已经固定。

* final

```
final String name = 'june';
final age = 11;
name = 'Alice'; // Error: 一个 final 变量只能被设置一次。
```

* const <br>
编译时就固定变量的值,类级别的变量需要使用 static const

```
const pi = 3.14159;
const double circle = 2 * pi * 2;
print(circle);  //12.56636
```
Const 关键字不仅可以用于声明常量变量。 还可以用来创建常量值，以及声明创建常量值的构造函数。 任何变量都可以拥有常量值。

```
var foo = const [];  //常量值
final bar = const [];
const baz = []; //声明const的初始化表达式中const可以被省略
//非Final，非const的变量是可以被修改的,即使这些变量曾经引用过const值。
foo = [1, 2, 3]; // 曾经引用过const []常量值。
```

### 内建类型

```
Number
String
Boolean
List (也被称为 Array)
Map
Set
Rune (用于在字符串中表示 Unicode 字符)
Symbol
```
##### Number
Number有 int 和 double两种类型

```
var x = 1;
var hex = 0xDEADBEEF;
var y = 1.1;
var exponents = 1.42e5;
double x = 1; //int 字面量会自动转换成 double 类型
//String -> int
var one = int.parse('1');
//String -> double
var pointX = double.parse('1.1');
//int -> String
String oneAsStr = 1.toString();
//double -> String
String piAsString = 3.14.toStringAsFixed(2);
```

##### String
* 用' '或者" "创建

```
var s1 = 'Single quotes'
var s2 = "Double quotes"
var s3 = 'It\'s easy to' //转义\
var s4 = "It's even easier"
```
* ${表达式}

```
var s = 'string interpolation';
var s2 = 'ss ${s}';
```
* == 运算符用来测试两个对象是否相等

```
var ss1 = 'String concatenation';
print(ss1 == 'String concatenation'); //true
```

* 三个单引号或者三个双引号实现多行字符串对象的创建

```
var sss1 = '''
you can create
multi-line strings like this one.
''';
print(sss1);
```
* 使用 r 前缀，可以创建 “原始 raw” 字符串：

```
var s = r"In a raw string, even \n isn't special.";

```

##### Boolean
使用bool类型表示布尔值 true flase

##### List

```
var list = [1,2,3]; //推断为 List<int>
print(list.length);
print(list[1]);
//在 List 字面量之前添加 const 关键字，可以定义 List 类型的编译时常量
var constantList = const [1,2,3];
//constantList[1] = 1; //错误
```

##### Set
set 唯一、无序的集合

```
var setStr = {'book','desk','door'}; //推断为Set<String> 类型
//创建一个空集
var names1 = <String>{} //{}前必须指定类型
Set<String> names2 = {}; //指定类型
var names3 = {}; //此创建了一个map类型 Map<dynamic, dynamic> 
//add  addAll 添加元素
var elements = <String>{};
elements.add('hello');
//const 创建运行时常量
final constanstSet = const {
 'flo',
 'wer',
 'wey'
};
```

##### Map

```
//创建并初始化
var gifts = {
    'first': 'apple',
    'second': 'cup',
    'fifth': 'car'
}; //Map<String,String>
var weeks = {
  1:'Monday',
  2:'Tuesday'
};//Map<int, String> 

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
final constantMap = const {
	2:'Two',
	3:'Three'
};
```

### 函数 Function类型
* 函数可以被赋值给变量或者作为参数传递给其他函数。 也可以把 Dart 类的实例当做方法来调用。

```
int sum(int a,int b){
  return a + b;
}
//如果函数中只有一句表达式，可以使用简写语法
int sum2(int a, int b) => a + b;

```
##### 参数
* 函数有两种参数类型: required 和 optional。 required 类型参数在参数最前面， 随后是 optional 类型参数。 

1、 可选命名参数

```
//可选命名参数 使用"{}"包围的参数属于可选命名参数
void _buildThree(int num, {String name, int range}) {
}

//可选参数设置默认值
void _buildThree(int num, {String name, int range = 10}) {
}

//调用时，使用paramName:value的形式指定为哪个可选参数赋值
_buildThree(10,range: 1);
```

2、 可选位置参数<br>
在方法参数中，使用"[]"包围的参数属于可选位置参数

```
void _buildHouse(int num, [String where, int range]) {
}
  
void _buildHouseAndDefaultValue(int num, 
[String where = 'Shanghai', int range]) {

}
//调用包含可选位置参数的方法时，无需使用paramName:value的形式
_buildHouse(10,10); //不可行的
_buildHouse(10,'shenzhen',10); //可行的
_buildHouseAndDefaultValue(10,10); //不可行的
_buildHouseAndDefaultValue(10,'shenzhen',10); //可行的
```

3、默认参数值

```
//list或map可以作为默认值传递
void doStuff(
    {List<int> list = const [1, 2, 3],
    Map<String, String> gifts = const {
      'first': 'paper',
      'second': 'cotton',
      'third': 'leather'
    }}) {
  print('list:  $list');
  print('gifts: $gifts');
}
```

##### main() 函数
任何应用都必须有一个顶级 main() 函数，作为应用服务的入口。 main() 函数返回值为空，参数为一个可选的 List<String> 。

```
//命令行应用的 main() 函数  运行应用： dart main.dart 1 test
void main(List<String> arguments){
  print(arguments);
  
  assert(arguments.length == 2);
  assert(int.parse(arguments[0]) == 1);
  assert(arguments[1] == 'test');
}
```
##### 函数是一等对象

```
//函数作为参数
void printElement(int element) {
  print(element);
}
var list1 = [1, 2, 3, 4, 5, 6];
list1.forEach(printElement);

//函数赋值给变量  匿名函数
var upLitter = (msg) => '!!! ${msg.toUpperCase()} !!!';
print(upLitter('hello')); //!!! HELLO !!!
```
##### 匿名函数
也被称为 lambda 或者 closure

```
var list2 = ['apple', 'bananas', 'oranges'];
list2.forEach((item) {
  print('${list2.indexOf(item)} : ${item}');
});
list2.forEach(
    (item) => print('${list.indexOf(item)}: $item'));
/**
0 : apple
1 : bananas
2 : oranges
*/
```
### 运算符

```
a++
a + b
a = b
a == b
c ? a : b
a is T

a = 0;
b = ++a; // a自加后赋值给b。
assert(a == b); // 1 == 1

a = 0;
b = a++; // a先赋值给b后，a自加。
assert(a != b); // 1 != 0

a = 0;
b = --a; // a自减后赋值给b。
assert(a == b); // -1 == -1

a = 0;
b = a--; // a先赋值给b后，a自减。
assert(a != b); // -1 != 0
```
##### as
将对象强制转换为特定类型
##### is
obj is Object 总是true。 但是只有obj实现了T的接口时，obj is T 才是true。
##### is!
##### ??=
只有当被赋值的变量为 null 时才会赋值给它

```
// 如果b为空时，将变量赋值给b，否则，b的值保持不变。
b ??= value;
```
##### ??
expr1 ?? expr2
如果 expr1 是 non-null， 返回 expr1 的值； 否则, 执行并返回 expr2 的值。

```
String playerName(String name) => name ?? 'Guest';
```

##### 级联运算符 (..)
可以实现对同一个对像进行一系列的操作。 除了调用函数， 还可以访问同一对象上的字段属性。 这通常可以节省创建临时变量的步骤， 同时编写出更流畅的代码。

```
querySelector('#confirm') // 获取对象。
  ..text = 'Confirm' // 调用成员变量。
  ..classes.add('important')
  ..onClick.listen((e) => window.alert('Confirmed!'));
//上面的代码等价于  
var button = querySelector('#confirm');
button.text = 'Confirm';
button.classes.add('important');
button.onClick.listen((e) => window.alert('Confirmed!'));  

//sb.write() 函数调用返回 void， 
var sb = StringBuffer();
sb.write('foo')
  ..write('bar'); // Error: 不能在 void 对象上创建级联操作。
```
### 流程控制语句
##### if 和 else
##### for 循环   for in
##### while 和 do-while
##### break 和 continue
##### switch 和 case
### 异常
##### throw
```
throw FormatException('Expected at least 1 section');
throw 'Out of llamas!'; //抛出任意的对象
```
##### catch

```
try {
  breedMoreLlamas();
} on OutOfLlamasException {
  buyMoreLlamas();
}

//捕获语句中可以同时使用 on 和 catch ，也可以单独分开使用。 使用 on 来指定异常类型， 使用 catch 来 捕获异常对象。
try {
  breedMoreLlamas();
} on OutOfLlamasException {
  // 一个特殊的异常
  buyMoreLlamas();
} on Exception catch (e) {
  // 其他任何异常
  print('Unknown exception: $e');
} catch (e) {
  // 没有指定的类型，处理所有异常
  print('Something really unknown: $e');
}

//catch() 函数可以指定1到2个参数， 第一个参数为抛出的异常对象， 第二个为堆栈信息 
try {
  // ···
} on Exception catch (e) {
  print('Exception details:\n $e');
} catch (e, s) {
  print('Exception details:\n $e');
  print('Stack trace:\n $s');
}
```
##### finally

```
try {
  breedMoreLlamas();
} finally {
  // Always clean up, even if an exception is thrown.
  cleanLlamaStalls();
}

try {
  breedMoreLlamas();
} catch (e) {
  print('Error: $e'); // Handle the exception first.
} finally {
  cleanLlamaStalls(); // Then clean up.
}
```
### 类









