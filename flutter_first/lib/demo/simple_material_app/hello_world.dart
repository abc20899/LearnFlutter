import 'package:flutter/material.dart';

void main() => runApp(HelloWidget());

class HelloWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hello',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Simple Material App',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: Container(
            child: Text(
              'Hello World',
              style: TextStyle(color: Colors.deepOrange),
            ),
          ),
        ),
      ),
    );
  }
}
