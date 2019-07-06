import 'package:flutter/material.dart';
import 'First.dart';
import 'Second.dart';
import 'Third.dart';

//TabBar  TabBarView
main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  TabBar getTabBar() {
    return TabBar(
      tabs: <Tab>[
        Tab(
          icon: Icon(Icons.favorite),
        ),
        Tab(
          icon: Icon(Icons.adb),
        ),
        Tab(
          icon: Icon(Icons.airline_seat_flat),
        )
      ],
      controller: tabController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: Scaffold(
        appBar: AppBar(
          title: Text('using tab'),
        ),
        body: TabBarView(
          children: <Widget>[
            First(),
            Second(),
            Third(),
          ],
          controller: tabController,
        ),
        bottomNavigationBar: Material(
          color: Colors.deepOrange,
          child: getTabBar(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }
}
