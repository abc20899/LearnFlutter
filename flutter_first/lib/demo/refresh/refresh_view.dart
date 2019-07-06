import 'dart:async';

import 'package:flutter/material.dart';

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
          title: Text('refresh'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2));
            return null;
          },
          child: ListView(
            children: <Widget>[
              Center(
                child: Text('dddd'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
