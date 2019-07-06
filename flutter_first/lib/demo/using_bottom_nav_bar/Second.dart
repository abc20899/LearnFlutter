import 'package:flutter/material.dart';

class Second extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.adb,
              color: Colors.green,
              size: 160.0,
            ),
            Text('Second tab')
          ],
        ),
      ),
    );
  }
}
