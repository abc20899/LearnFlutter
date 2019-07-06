import 'package:flutter/material.dart';
import 'package:flutter_first/demo/navigation_drawer/pages/settings.dart';

import 'account.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //构建抽屉
  Drawer getDrawer() {
    var headerChild = DrawerHeader(child: Text('Header'));
    var aboutChild = new AboutListTile(
        child: new Text("About"),
        applicationName: "Application Name",
        applicationVersion: "v1.0.0",
        applicationIcon: new Icon(Icons.adb),
        icon: new Icon(Icons.info));

    ListTile getNavItem(var icon, String s, String routeName) {
      return new ListTile(
        leading: new Icon(icon),
        title: new Text(s),
        onTap: () {
          setState(() {
            // pop closes the drawer
            Navigator.of(context).pop();
            // navigate to the route
            Navigator.of(context).pushNamed(routeName);
          });
        },
      );
    }

    //listview 元素
    var myNavChildren = [
      headerChild,
      getNavItem(Icons.settings, "Settings", SettingsScreen.routeName),
//      getNavItem(Icons.home, "Home", "/"),
      getNavItem(Icons.account_box, "Account", AccountScreen.routeName),
      aboutChild,
    ];
    ListView listView = ListView(
      children: myNavChildren,
    );
    return Drawer(
      child: listView,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Navigation Drawer Example"),
      ),
      body: new Container(
          child: new Center(
        child: new Text("Home Screen"),
      )),
      drawer: getDrawer(),
    );
  }
}
