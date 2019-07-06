import 'package:flutter/material.dart';
import './utils.dart' as utils;

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
      home: Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Container(
          child: Center(
            child: Text(
              'Hello world',
              style: TextStyle(color: Colors.white),
            ),
          ),
          decoration: BoxDecoration(
            gradient: utils.getCustomGradient(),
          ),
        ),
      ),
    );
  }
}
