import 'package:flutter/material.dart';

import 'about_page.dart';
import 'home_page.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: HomePage(),
      //路由列表
      routes: <String, WidgetBuilder>{
        //string-->WidgetBuilder
        AboutPage.routeName: (BuildContext context) => AboutPage()
      },
    );
  }
}
