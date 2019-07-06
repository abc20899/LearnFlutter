import 'package:flutter/material.dart';

void main() => runApp(ToolbarTest());

class ToolbarTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matinee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue, canvasColor: Colors.transparent),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          //左边菜单icon
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        centerTitle: true,
        title: Text(
          //中间标题
          'Matinee',
          style: TextStyle(color: Colors.white, fontSize: 17.0),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          //右边按钮事件
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      drawer: Drawer(
//        child: SettingsPage(),
          ),
      body: Container(),
    );
  }
}
