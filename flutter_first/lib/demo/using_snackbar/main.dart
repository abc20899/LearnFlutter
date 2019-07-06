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
          title: Text('Snackbar'),
        ),
        body: Center(
          child: MyButton(),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Hello! I am SnackBar :'),
          duration: Duration(seconds: 3),
          action: SnackBarAction(
              label: 'Hit Me (Action)',
              onPressed: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                    content:
                        Text('Hello! I am shown becoz you pressed Action :)')));
              }),
        ));
      },
      child: Text('show snackbar'),
    );
  }
}
