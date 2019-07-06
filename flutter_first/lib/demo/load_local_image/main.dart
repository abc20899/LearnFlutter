import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'local image',
      home: Scaffold(
        appBar: AppBar(
          title: Text('LocalImage'),
        ),
        body: Container(
          child: Center(
            child: Text(
              'Hello World',
              style: TextStyle(color: Colors.white),
            ),
          ),
          //设置Container的背景
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/lingjingru.jpeg'),
            fit: BoxFit.cover,
          )),
        ),
      ),
    );
  }
}
