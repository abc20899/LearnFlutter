import 'package:flutter/material.dart';

//void main() {
//  runApp(new Center(
//    child: new Text(
//      'Hello World!',
//      textDirection: TextDirection.ltr,
//    ),
//  ));
//}

void main() {
  runApp(new MaterialApp(
    title: 'My app', // used by the OS task switcher
    home: new MyScaffold(),
  ));
}
//为了继承主题数据，widget需要位于MaterialApp内才能正常显示， 因此我们使用MaterialApp来运行该应用。

class MyAppBar extends StatelessWidget {
  MyAppBar({this.title});

  // Widget子类中的字段往往都会定义为"final"
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 56.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: new BoxDecoration(color: Colors.blue[500]),
      // Row 是水平方向的线性布局（linear layout）
      child: new Row(
        //列表项的类型是 <Widget>
        children: <Widget>[
          new IconButton(
            icon: new Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: null, // null 会禁用 button
          ),
          // Expanded expands its child 填充剩余可用空间.
          new Expanded(
            child: title,
          ),
          new IconButton(
            icon: new Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Material 是UI呈现的“一张纸”
    return new Material(
      child: new Column(
        //垂直布局
        children: <Widget>[
          //列表项
          new MyAppBar(
            title: new Text(
              'Example title',
              style: Theme.of(context).primaryTextTheme.title,
            ),
          ),
          new Expanded(
            child: new Center(
              child: new Text('Hello, world!'),
            ),
          ),
        ],
      ),
    );
  }
}
