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
          title: Text('network_image'),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Image.network(
                    'https://github.com/nisrulz/flutter-examples/raw/develop/image_from_network/img/flutter_logo.png'),
                Image.network(
                    'https://github.com/nisrulz/flutter-examples/raw/develop/image_from_network/img/loop_anim.gif'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
