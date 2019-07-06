import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  final String barTitle;

  final Widget bodyWidget;

  final PreferredSizeWidget appbar_bottom_widget;

  MyApp({Key key, this.barTitle, this.bodyWidget, this.appbar_bottom_widget})
      : super(key: key);

  @override
  _MyAppState createState() =>
      _MyAppState(barTitle, bodyWidget, appbar_bottom_widget);
}

class _MyAppState extends State<MyApp> {
  final String _barTitle;

  final Widget _bodyWidget;

  final PreferredSizeWidget _appbar_bottom_widget;

  _MyAppState(this._barTitle, this._bodyWidget, this._appbar_bottom_widget)
      : super();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: Scaffold(
        appBar: AppBar(
          title: Text(_barTitle),
          bottom: _appbar_bottom_widget,
        ),
        body: _bodyWidget,
      ),
    );
  }
}
