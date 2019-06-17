import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_first/net/http.dart';
import 'package:flutter_first/utils/screen_util.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'models/banner_entity.dart';
import 'models/video_list_entity.dart';

//var BASE_URL = "https://api.moviefanclub.cn/dayu/";

void main() => runApp(TestApp());

class TestApp extends StatefulWidget {
  @override
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  VideoListEntity videoEntity = null;

  double width, height;

  @override
  void initState() {
    width = (window.physicalSize.width - 6) / 3;
    height = width / 0.75;
    getBannerData().then((banner) {
      setState(() {
        videoEntity = banner;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('测试网络框架'),
        ),
//        body: ListView(
//          shrinkWrap: true,
//          children: <Widget>[
////            firstSwiperView(),
//            _gridView(width, height),
//          ],
//        ),
//        body: _gridView(width, height),
        body: GridViewTest(),
      ),
    );
  }

  Widget firstSwiperView() {
    if (videoEntity != null && videoEntity.data != null) {
      return Container(
        width: window.physicalSize.width, //屏幕高度 px
        height: 210,
        child: Swiper(
          itemCount: videoEntity.data.length,
          itemBuilder: _swiperBuilder,
          pagination: SwiperPagination(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
              builder: DotSwiperPaginationBuilder(
                  color: Colors.black54, activeColor: Colors.white)),
          controller: SwiperController(),
          scrollDirection: Axis.horizontal,
          autoplay: true,
          onTap: (index) => print('点击了第$index'),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return Image.network(
      videoEntity.data[index].videoCover,
      fit: BoxFit.fill,
    );
  }
}

Future<VideoListEntity> getBannerData() async {
  var res = await httpManager.netFetch(
      'http://192.168.199.186:10000/api/videoList',
      {'page': 1, 'size': 10, 'type': 1},
      null,
      Options(method: 'post'));
  if (res != null && res.result) {
//    String jsonStr = json.encode(res.data);
//    print(jsonStr);
    var video_list = VideoListEntity.fromJson(res.data);
    return video_list;
  }
}

class GridViewTest extends StatefulWidget {
  @override
  GridViewState2 createState() => GridViewState2();
}

class GridViewState extends State {
  double width;
  double height;
  String url =
      "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2539428717.webp";

  @override
  void initState() {
    width = (window.physicalSize.width - 6) / 3;
    height = width / 0.75;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => new GridView.count(
      primary: false,
      padding: const EdgeInsets.all(0.0),
      //竖向间距
      mainAxisSpacing: 8,
      //横向Item的个数
      crossAxisCount: 3,
      //横向间距
      crossAxisSpacing: 1.5,
      children: buildGridTileList(5));

  List<Widget> buildGridTileList(int number) {
    List<Widget> widgetList = new List();
    for (int i = 0; i < number; i++) {
      widgetList.add(getItemWidget());
    }
    return widgetList;
  }

  Widget getItemWidget() {
    return Container(
      child: Image.network(url),
    );
  }
}

class GridViewState2 extends State {
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
