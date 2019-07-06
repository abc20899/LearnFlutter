import 'package:flutter/material.dart';

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.favorite,
              color: Colors.red,
              size: 160.0,
            ),
            Text('First tab')
          ],
        ),
      ),
    );
  }
}
