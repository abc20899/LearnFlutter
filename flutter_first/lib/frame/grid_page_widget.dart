import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_first/utils/screen_util.dart';

class GridPageWidget extends StatefulWidget {
  @override
  GridPageWidgetState createState() => GridPageWidgetState();
}

class GridPageWidgetState extends State<GridPageWidget> {
  double width;
  double height;
  String url =
      "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2539428717.webp";

  @override
  void initState() {
    width = window.physicalSize.width / 3;
    height = width / 0.75;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GridView(
      primary: false,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: ScreenUtil.px2dp(width),
        mainAxisSpacing: 10, //竖向间距
        crossAxisSpacing: 1.5, //横向间距
        childAspectRatio: 0.66, //item宽高比 图片0.75  item:0.66
      ),
      padding: EdgeInsets.zero,
      children: buildGridTileList(10));

  List<Widget> buildGridTileList(int number) {
    List<Widget> widgetList = new List();
    for (int i = 0; i < number; i++) {
      widgetList.add(getItemWidget(number));
    }
    return widgetList;
  }

  Widget getItemWidget(int index) {
    return GestureDetector(
      onTap: onItemClick(index), //点击事件
      child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: <Widget>[
                  Image.network(url), //封面
                  Container(
                    //更新集数
                    color: Color(0xcc000000),
                    margin: EdgeInsets.only(bottom: 5.0),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 4, top: 1.5, right: 4, bottom: 1.5),
                      child: Text(
                        '更新到23集',
                        style: TextStyle(color: Colors.white, fontSize: 9.0),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 2)), //距离顶部8dp
              Text(
                '倚天屠龙记',
                style: TextStyle(
                    fontSize: 13,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w500),
              )
            ],
          )),
    );
  }

  onItemClick(int index) {}
}
