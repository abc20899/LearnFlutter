import 'package:flutter/material.dart';

void main() => runApp(StatelessApp());

class StatelessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      title: 'StatelessApp',
      home: Scaffold(
        appBar: AppBar(
          title: Text('StatelessApp'),
        ),
        body: Container(
          padding: EdgeInsets.all(2.0),
          child: Center(
            child: SingleChildScrollView(
              child: CardList(),
            ),
          ),
        ),
      ),
    );
  }
}

class CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double myTextSize = 30.0;
    final double myIconSize = 40.0;
    final TextStyle myTextStyle =
        new TextStyle(color: Colors.grey, fontSize: myTextSize);

    return Column(
      //使卡片在水平轴上伸展
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        MyCard(
          title: Text(
            'Favorite',
            style: myTextStyle,
          ),
          icon: Icon(
            Icons.favorite,
            size: myIconSize,
            color: Colors.red,
          ),
        ),
        MyCard(
          title: Text(
            'Alarm',
            style: myTextStyle,
          ),
          icon: Icon(
            Icons.alarm,
            size: myIconSize,
            color: Colors.green,
          ),
        ),
        MyCard(
          title: Text(
            'Done',
            style: myTextStyle,
          ),
          icon: Icon(
            Icons.done,
            size: myIconSize,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}

class MyCard extends StatelessWidget {
  final Text title;
  final Icon icon;

  MyCard({this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 1.0),
      child: Card(
        elevation: 3.0,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              this.title,
              this.icon,
            ],
          ),
        ),
      ),
    );
  }
}
