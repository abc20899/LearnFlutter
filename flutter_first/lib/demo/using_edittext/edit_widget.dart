import 'package:flutter/material.dart';

void main() => runApp(EditTest());

class EditTest extends StatefulWidget {
  @override
  _EditTestState createState() => _EditTestState();
}

class _EditTestState extends State<EditTest> {
  String results = '';

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'edit test',
      home: Scaffold(
        appBar: AppBar(
            title: Text(
          'EditText App',
          style: TextStyle(color: Colors.white),
        )),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: "Enter text here..."),
                controller: controller,
                onSubmitted: (String str) {
                  setState(() {
                    results = results + str;
                    controller.text = "";
                  });
                },
              ),
              Text(results),
            ],
          ),
        ),
      ),
    );
  }
}
