import 'package:flutter/material.dart';
import 'package:flutter_first/demo/navigation_drawer/pages/account.dart';
import 'package:flutter_first/demo/navigation_drawer/pages/home.dart';
import 'package:flutter_first/demo/navigation_drawer/pages/settings.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      routes: <String, WidgetBuilder>{
        // 路由定义
        SettingsScreen.routeName: (BuildContext context) =>
            new SettingsScreen(),
        AccountScreen.routeName: (BuildContext context) => new AccountScreen(),
      },
      home: HomeScreen(), //主页包含抽屉
    );
  }
}
