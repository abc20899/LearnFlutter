import 'package:flutter/material.dart';
import 'package:flutter_first/demo/base/main.dart';

void main() => runApp(MyApp(
      barTitle: 'dialog',
      bodyWidget: BodyWidget(),
    ));

class BodyWidget extends StatefulWidget {
  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  AlertDialog dialog = AlertDialog(
    title: Text('title'),
    content: Text('Hello World'),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FlatButton(
            onPressed: () {
              showDialog(context: context, builder: (context) => dialog);
            },
            child: Text('open dialog')),
      ),
    );
  }
}
