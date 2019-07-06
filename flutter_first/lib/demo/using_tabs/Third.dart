import 'package:flutter/material.dart';

class Third extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.airline_seat_flat,
              color: Colors.blue,
              size: 160.0,
            ),
            Text('Third tab')
          ],
        ),
      ),
    );
  }
}
