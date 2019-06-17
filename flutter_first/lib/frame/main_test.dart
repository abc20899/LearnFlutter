import 'package:flutter/material.dart';

import 'BottomTabBarWidget.dart';
import 'PageFirstWidget.dart';
import 'TopTabBarWidget.dart';

void main() => runApp(new TestApp());

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('title'),
        ),
        body: ButtonWidget());
  }
}

class ButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TopTabBarWidget()));
            },
            child: Text(
              'top tab',
              style: TextStyle(color: Colors.white, fontSize: 13.0),
            ),
            color: Colors.blue,
          ),
          FlatButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomTabBarWidget()));
            },
            child: Text(
              'bottom tab',
              style: TextStyle(color: Colors.white, fontSize: 13.0),
            ),
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
