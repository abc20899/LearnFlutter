import 'package:flutter/material.dart';

void main() => runApp(TestApp());

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'layout test',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('布局测试'),
      ),
//      body: BottomItem(),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return BottomItem();
          }),
    );
  }
}

class BottomItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        //卡片包装
        child: FlatButton(
            onPressed: () {
              print('点击了');
            },
            child: Padding(
              padding: EdgeInsets.only(
                  left: 0.0, top: 10.0, right: 10.0, bottom: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, //竖向最小高度
                children: <Widget>[
                  //文本描述
                  Container(
                    child: Text(
                      '这是一点文本描述',
                      style: TextStyle(color: Colors.grey),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    margin: EdgeInsets.only(top: 6.0, bottom: 2.0),
                    alignment: Alignment.topLeft,
                  ),
                  Padding(padding: EdgeInsets.all(10.0)),
                  //三个平均分配的横向图标文字
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      bottomItem(Icons.star, "1000"),
                      bottomItem(Icons.link, "1000"),
                      bottomItem(Icons.subject, "1000"),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  bottomItem(IconData _icon, String _text) {
    return Expanded(
        flex: 1,
        child: Center(
          child: Row(
            //主轴居中,即是横向居中
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max, //大小按最大充满
            crossAxisAlignment: CrossAxisAlignment.center, //竖向也居中
            children: <Widget>[
              Icon(
                _icon,
                size: 16.0,
                color: Colors.grey,
              ),
              Padding(padding: EdgeInsets.only(left: 5.0)), //间隔
              Text(
                _text,
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
                overflow: TextOverflow.ellipsis, //超过的省略为...显示
                maxLines: 1, //最多一行
              )
            ],
          ),
        ));
  }
}
