import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String key = 'counter';

  int counter;

  @override
  void initState() {
    super.initState();
    loadSaveData();
  }

  void loadSaveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = (prefs.getInt(key) ?? 0);
    });
  }

  void Increment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = (prefs.getInt(key) ?? 0) + 1;
    });
    prefs.setInt(key, counter);
  }

  void Decrement() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = (prefs.getInt(key) ?? 0) - 1;
    });
    prefs.setInt(key, counter);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: Scaffold(
        appBar: AppBar(
          title: Text('sp'),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  '$counter',
                  textScaleFactor: 10.0,
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                RaisedButton(
                  onPressed: Increment,
                  child: Text('Increment Counter'),
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                RaisedButton(
                  onPressed: Decrement,
                  child: Text('Decrement Counter'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
