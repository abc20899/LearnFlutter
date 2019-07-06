import 'package:flutter/material.dart';

void main() => runApp(StatefulApp());

class StatefulApp extends StatefulWidget {
  @override
  _StatefulAppState createState() => _StatefulAppState();
}

class _StatefulAppState extends State<StatefulApp> {
  List<String> words = <String>['Flutter', 'is', 'very', 'cool'];
  int count = 0;
  String word = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StatefulApp',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: Scaffold(
        appBar: AppBar(
          title: Text('StatefulApp'),
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  word,
                  style: TextStyle(fontSize: 24.0, color: Colors.black54),
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                RaisedButton(
                  color: Colors.red,
                  onPressed: onBtnPress,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Press me',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onBtnPress() {
    setState(() {
      count = count < words.length ? count + 1 : 0;
      word = words[count];
    });
  }
}
