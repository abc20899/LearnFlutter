import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_first/demo/base/main.dart';

void main() => runApp(MyApp(
      barTitle: 'local json',
      bodyWidget: BodyWidget(),
    ));

class BodyWidget extends StatefulWidget {
  @override
  _BodyWidget createState() => _BodyWidget();
}

class _BodyWidget extends State<BodyWidget> {
  @override
  Widget build(BuildContext context) {
    return body(context);
  }
}

Widget body(BuildContext context) {
  return Container(
    child: Center(
      child: FutureBuilder(
          //在StatefulWidget中加载
          future: DefaultAssetBundle.of(context).loadString('jsons/data.json'),
          builder: (context, str) {
            //解析json
            var new_data = json.decode(str.data.toString());
            return ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new Text("Name: " + new_data[index]['name']),
                      new Text("Height: " + new_data[index]['height']),
                      new Text("Mass: " + new_data[index]['mass']),
                      new Text("Hair Color: " + new_data[index]['hair_color']),
                      new Text("Skin Color: " + new_data[index]['skin_color']),
                      new Text("Eye Color: " + new_data[index]['eye_color']),
                      new Text("Birth Year: " + new_data[index]['birth_year']),
                      new Text("Gender: " + new_data[index]['gender'])
                    ],
                  ),
                );
              },
              itemCount: new_data == null ? 0 : new_data.length,
            );
          }),
    ),
  );
}
