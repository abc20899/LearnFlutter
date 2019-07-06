import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> _fruits = <String>[
    "Apple",
    "Banana",
    "Pineapple",
    "Mango",
    "Grapes"
  ];

  //DropdownMenuItem  dynamic类型
  List<DropdownMenuItem<dynamic>> _dropDownMenuItems;
  String _selectedFruit;

  @override
  void initState() {
    super.initState();
    _dropDownMenuItems = List<DropdownMenuItem<dynamic>>();
    for (String str in _fruits) {
      DropdownMenuItem item = DropdownMenuItem(
        child: Text(str),
        value: str,
      );
      _dropDownMenuItems.add(item);
    }
    _selectedFruit = _dropDownMenuItems[0].value;
  }

  void changeItem(dynamic selectFruit) {
    setState(() {
      _selectedFruit = selectFruit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text("Please choose a fruit: "),
                DropdownButton(
                  items: _dropDownMenuItems,
                  onChanged: changeItem,
                  value: _selectedFruit,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
