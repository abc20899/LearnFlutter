import 'package:flutter/material.dart';

import 'about_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Home Page\nClick on below icon to goto About Page',
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              IconButton(
                icon: Icon(
                  Icons.info,
                  color: Colors.blue,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(AboutPage.routeName);
                },
                iconSize: 80.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
