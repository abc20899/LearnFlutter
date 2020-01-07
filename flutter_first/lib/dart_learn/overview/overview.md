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

















