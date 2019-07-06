import 'package:flutter/material.dart';

void main() => runApp(MyApp()); //单行函数或方法的简

class MyApp extends StatelessWidget {
  //根widget  应用本身也是一个widget
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', //应用名称
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ), //主题
      home: MyHomePage(title: 'Flutter Demo Home Page'), //应用首页路由
    );
  }
}
//1、MyApp类代表Flutter应用，它继承了 StatelessWidget类，这也就意味着应用本身也是一个widget。
//2、在Flutter中，大多数东西都是widget，包括对齐(alignment)、填充(padding)和布局(layout)。
//3、Flutter在构建页面时，会调用组件的build方法，widget的主要工作是提供一个build()方法来描述如何构建UI界面
//（通常是通过组合、拼装其它基础widget）。
//4、MaterialApp 是Material库中提供的Flutter APP框架，通过它可以设置应用的名称、主题、语言、首页及路由列表等。MaterialApp也是一个widget。
//5、home 为Flutter应用的首页，它也是一个widget。

//首页
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//1、Stateful widget可以拥有状态，这些状态在widget生命周期中是可以变的，而Stateless widget是不可变的。
//2、Stateful widget至少由两个类组成：一个StatefulWidget类。
//           一个 State类； StatefulWidget类本身是不变的，但是 State类中持有的状态在widget生命周期中可能会发生变化。
//3、MyHomePage类中并没有build方法，取而代之的是，build方法被挪到了_MyHomePageState方法中

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            FlatButton(
              onPressed: () {
                //导航到新路由
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return new NewPage();
                }));
              },
              child: new Text('open new route'),
              textColor: Colors.blue,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

//1、状态：int _counter = 0;
//2、设置状态的自增函数。 void _incrementCounter()
//3、setState方法的作用是通知Flutter框架，有状态发生了改变，Flutter框架收到通知后，会执行build方法来根据新的状态重新构建界面
//4、当MyHomePage第一次创建时，_MyHomePageState类会被创建，当初始化完成后，Flutter框架会调用Widget的build方法来构建widget树
//5、Scaffold 是 Material库中提供的一个widget, 它提供了默认的导航栏、标题和包含主屏幕widget树的body属性。widget树可以很复杂。
//6、body的widget树中包含了一个Center widget，Center 可以将其子widget树对齐到屏幕中心， Center 子widget是一个Column widget，
//   Column的作用是将其所有子widget沿屏幕垂直方向依次排列， 此例中Column包含两个 Text子widget，
//   第一个Text widget显示固定文本 “You have pushed the button this many times:”，第二个Text widget显示_counter状态的数值。
//7、floatingActionButton是页面右下角的带“➕”的悬浮按钮，它的onPressed属性接受一个回调函数，代表它被点击后的处理器，
//   本例中直接将_incrementCounter作为其处理函数。

//8、MaterialPageRoute继承自PageRoute类，PageRoute类是一个抽象类，表示占有整个屏幕空间的一个模态路由页面，
//  它还定义了路由构建及切换时过渡动画的相关接口及属性。MaterialPageRoute 是Material组件库的一个Widget，它可以针对不同平台，
//  实现与平台页面切换动画风格一致的路由切换动画：
//  如果想自定义路由切换动画，可以自己继承PageRoute来实现，我们将在后面介绍动画时，实现一个自定义的路由Widget。

//9、Navigator是一个路由管理的widget，它通过一个栈来管理一个路由widget集合
//   Future push(BuildContext context, Route route)  打开新的页面
//   bool pop(BuildContext context, [ result ])  将栈顶路由出栈
//   Navigator 还有很多其它方法，如Navigator.replace、Navigator.popUntil等

/**
 * 注册路由表
    routes:{
      "new_page":(context)=>NewRoute(),
    } ,
   通过路由名打开新路由页
   Navigator.pushNamed(context, "new_page");

   在打开路由时传递参数
   Navigator.of(context).pushNamed("new_page", arguments: "hi");

   获取路由参数
   var args = ModalRoute.of(context).settings.arguments
 * */

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text('New Route'),
      ),
      body: new Center(
        child: new Text('this is a new page'),
      ),
    );
  }
}
