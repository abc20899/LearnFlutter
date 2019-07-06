import 'package:flutter/material.dart';

void main() => runApp(TestApp());

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test app',
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldRoute();
  }
}

class ScaffoldRoute extends StatefulWidget {
  @override
  _ScaffoldRouteState2 createState() => _ScaffoldRouteState2();
}

class _ScaffoldRouteState extends State<ScaffoldRoute> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //导航栏
        title: Text('App Name'), //左侧标题
        actions: <Widget>[
          //导航栏右侧菜单
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
        ],
      ),
      drawer: MyDrawer(), //抽屉
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), title: Text('Business')),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), title: Text('School')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
          //悬浮按钮
          child: Icon(Icons.add),
          onPressed: _onAdd),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAdd() {}
}

class _ScaffoldRouteState2 extends State<ScaffoldRoute>
    with SingleTickerProviderStateMixin {
  TabController _tabController; //需要定义一个Controller

  List tabs = ["历史", "新闻", "图片"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: tabs.length,
        vsync: this); // vsync :SingleTickerProviderStateMixin
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //导航栏
        title: Text('App Name'), //左侧标题
        actions: <Widget>[
          //导航栏右侧菜单
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs
              .map((e) => Tab(text: e))
              .toList(), //tabs字符串数组变换为 Tab widget数组
        ),
      ),
      drawer: MyDrawer(), //抽屉
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((e) {
          return Container(
            alignment: Alignment.center,
            child: Text(e, textScaleFactor: 5),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
          //悬浮按钮
          child: Icon(Icons.add),
          onPressed: _onAdd),
    );
  }

  void _onAdd() {}
}
/**
 * Tab({
    Key key,
    this.text, // 菜单文本
    this.icon, // 菜单图标
    this.child, // 自定义Widget
    })
    //监听tab点击
    _tabController.addListener((){
    switch(_tabController.index){
    case 1: ...;
    case 2: ... ;
    }
    });

    TabBarView :显示tab页面的内容

 * */

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        // DrawerHeader consumes top MediaQuery padding.
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/wechat_icon.png",
                        width: 80,
                      ),
                    ),
                  ),
                  Text(
                    "Wendux",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text('Add account'),
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Manage accounts'),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

/**
 * appbar 打开抽屉按钮
 * leading: Builder(builder: (context) {
    return IconButton(
    icon: Icon(Icons.dashboard, color: Colors.white), //自定义图标
    onPressed: () {
    // 打开抽屉菜单
    Scaffold.of(context).openDrawer();
    },
    );
    }),

    通过Scaffold.of(context)可以获取父级最近的Scaffold Widget的State对象

    Flutter还有一种通用的获取StatefulWidget对象State的方法：通过GlobalKey来获取！
    1、给目标StatefulWidget添加GlobalKey
    //定义一个globalKey, 由于GlobalKey要保持全局唯一性，我们使用静态变量存储
    static GlobalKey<ScaffoldState> _globalKey= new GlobalKey();
    ...
    Scaffold(
    key: _globalKey , //设置key
    ...
    )
    2、通过GlobalKey来获取State对象
    _globalKey.currentState.openDrawer()
 * */
