import 'package:flutter/material.dart';
import 'dart:async';

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
          title: Text('Stream Builder'),
        ),
        body: CountPage(),
      ),
    );
  }
}

class CountPage extends StatefulWidget {
  @override
  _CountPageState createState() => _CountPageState();
}

class _CountPageState extends State<CountPage> {
  final StreamController<int> streamController = StreamController<int>();
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.all(20.0)),
          //监听流，每次有一个新值流出这个流时，我们用该值更新Text ;
          StreamBuilder<int>(
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return Text('You hit me: ${snapshot.data} times');
            },
            initialData: counter,
            stream: streamController.stream,
          ),
          Padding(padding: EdgeInsets.all(20.0)),
          RaisedButton(
            onPressed: () {
              //注入到stream中值会导致监听它(stream)的StreamBuilder重建并 ‘刷新’计数器;
              streamController.sink.add(++counter);
            },
            child: Text('press me'),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    streamController.close();
  }
}
