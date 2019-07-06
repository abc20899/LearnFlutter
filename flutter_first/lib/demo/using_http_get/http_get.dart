import 'package:flutter/material.dart';
import 'package:flutter_first/demo/base/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp(
      barTitle: 'usinghttp',
      bodyWidget: BodyWidget(),
    ));

class BodyWidget extends StatefulWidget {
  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  final String url = "https://swapi.co/api/people";
  List data;

  //获取数据
  Future<String> getJsonData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    print(response.body);

    setState(() {
      var dataConvertedToJSON = json.decode(response.body);
      data = dataConvertedToJSON['results'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  data[index]['name'],
                  style:
                      TextStyle(color: Colors.lightBlueAccent, fontSize: 20.0),
                ),
              ),
            );
          },
          itemCount: data == null ? 0 : data.length,
        ),
      ),
    );
  }
}
