import 'package:flutter/material.dart';

void main() => runApp(ThemeApp());

class ThemeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'using theme',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.lightGreenAccent,
        backgroundColor: Colors.black12,
      ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Using Theme'),
      ),
      body: Container(
        //另一种设置背景颜色的方法
//        decoration: BoxDecoration(color: Colors.black87),
        child: Center(
          child: Container(
            //主题颜色
            color: Theme.of(context).accentColor,
            child: Text(
              'Hello World!',
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
      ),
      floatingActionButton: Theme(
          data: Theme.of(context).copyWith(accentColor: Colors.pinkAccent),
          child: FloatingActionButton(
            onPressed: null,
            child: Icon(Icons.add),
          )),
    );
  }
}
