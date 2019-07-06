import 'package:flutter/material.dart';

//功能型Widget指的是不会影响UI布局及外观的Widget，它们通常具有一定的功能，如事件监听、数据存储等，
// 我们之前介绍过的FocusScope（焦点控制）、PageStorage（数据存储）、NotificationListener（事件监听）都属于功能型Widget。

void main() => runApp(TestApp());

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'test app',
//      theme: ThemeData(primaryColor: Colors.blue),
//      home: new Echo(text: 'echo'),
//      home: new HomePage(),
      home: ThemeTestRoute(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('功能类Widget'),
      ),
      body: new WillPopScopeTestRoute(),
    );
  }
}

//WillPopScope 拦截返回键
/**
 * const WillPopScope({
    ...
    @required WillPopCallback onWillPop,
    @required Widget child
    })
    onWillPop是一个回调函数，当用户点击返回按钮时调用（包括导航返回按钮及Android物理返回按钮），该回调需要返回一个Future对象，
    如果返回的Future最终值为false时，则当前路由不出栈(不会返回)，最终值为true时，当前路由出栈退出。我们需要提供这个回调来决定是否退出。
 * */

class WillPopScopeTestRoute extends StatefulWidget {
  @override
  WillPopScopeTestRouteState createState() {
    return new WillPopScopeTestRouteState();
  }
}

class WillPopScopeTestRouteState extends State<WillPopScopeTestRoute> {
  DateTime _lastPressedAt; //上次点击时间

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt) >
                  Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressedAt = DateTime.now();
            return false;
          }
          return true;
        },
        child: Container(
          alignment: Alignment.center,
          child: Text("1秒内连续按两次返回键退出"),
        ));
  }
}

//InheritedWidget是Flutter中非常重要的一个功能型Widget，它可以高效的将数据在Widget树中向下传递、共享

/**
 * ThemeData({
    Brightness brightness, //深色还是浅色
    MaterialColor primarySwatch, //主题颜色样本，见下面介绍
    Color primaryColor, //主色，决定导航栏颜色
    Color accentColor, //次级色，决定大多数Widget的颜色，如进度条、开关等。
    Color cardColor, //卡片颜色
    Color dividerColor, //分割线颜色
    ButtonThemeData buttonTheme, //按钮主题
    Color cursorColor, //输入框光标颜色
    Color dialogBackgroundColor,//对话框背景颜色
    String fontFamily, //文字字体
    TextTheme textTheme,// 字体主题，包括标题、body等文字样式
    IconThemeData iconTheme, // Icon的默认样式
    TargetPlatform platform, //指定平台，应用特定平台控件风格
    ...
    })
 * */

class ThemeTestRoute extends StatefulWidget {
  @override
  _ThemeTestRouteState createState() => new _ThemeTestRouteState();
}

class _ThemeTestRouteState extends State<ThemeTestRoute> {
  Color _themeColor = Colors.teal; //当前路由主题色

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: ThemeData(
          primarySwatch: _themeColor, //用于导航栏、FloatingActionButton的背景色等
          iconTheme: IconThemeData(color: _themeColor) //用于Icon颜色
          ),
      child: Scaffold(
        appBar: AppBar(title: Text("主题测试")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //第一行Icon使用主题中的iconTheme
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Icon(Icons.favorite),
              Icon(Icons.airport_shuttle),
              Text("  颜色跟随主题")
            ]),
            //为第二行Icon自定义颜色（固定为黑色)
            Theme(
              data: themeData.copyWith(
                iconTheme: themeData.iconTheme.copyWith(color: Colors.black),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.favorite),
                    Icon(Icons.airport_shuttle),
                    Text("  颜色固定黑色")
                  ]),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => //切换主题
                setState(() => _themeColor =
                    _themeColor == Colors.teal ? Colors.blue : Colors.teal),
            child: Icon(Icons.palette)),
      ),
    );
  }
}
