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
          title: Text('CustomFont'),
        ),
        body: Container(
          child: Center(
            child: Text(
              'The quick brown fox jumps over the lazy dog',
              textAlign: TextAlign.center,
              style: utils.getCustomFontTextStyle(),
            ),
          ),
        ),
      ),
    );
  }
}
