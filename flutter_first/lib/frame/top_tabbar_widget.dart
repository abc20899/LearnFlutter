import 'package:flutter/material.dart';

import 'grid_page_widget.dart';
import 'june_tabbar_widget.dart';
import 'list_load_page.dart';
import 'page_first_widget.dart';

class TopTabBarWidget extends StatefulWidget {
  @override
  _TopTabBarWidgetState createState() => _TopTabBarWidgetState();
}

class _TopTabBarWidgetState extends State<TopTabBarWidget> {
  final List<String> listTabs = <String>[
    '搞笑',
    '剧情',
    '预告',
    '混剪',
    '生活',
    '美食',
    '萌宠',
    '游戏',
    '时尚',
    '音乐',
    '综艺',
    '创意',
    '爱情',
    '旅行',
    '科技',
    '记录'
  ];

  _renderTabs() {
    List<Widget> list = new List();
    for (int i = 0; i < listTabs.length; i++) {
      list.add(Container(
        padding: EdgeInsets.only(bottom: 15.0),
        child: Text(
          listTabs[i],
          maxLines: 1,
          style: TextStyle(color: Colors.white),
        ),
      ));
    }
    return list;
  }

  _renderPages() {
    return [
      PageFirstWidget(),
      GridPageWidget(),
      ListLoadPage(),
      PageFirstWidget(),
      PageFirstWidget(),
      PageFirstWidget(),
      PageFirstWidget(),
      PageFirstWidget(),
      PageFirstWidget(),
      PageFirstWidget(),
      PageFirstWidget(),
      PageFirstWidget(),
      PageFirstWidget(),
      PageFirstWidget(),
      PageFirstWidget(),
      PageFirstWidget(),
      PageFirstWidget()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return JuneTabBarWidget(
      type: JuneTabBarWidget.TOP_BAR,
      tabItems: _renderTabs(),
      tabViews: _renderPages(),
      backgroundColor: Colors.lightBlueAccent,
      indicatorColor: Theme.of(context).primaryColor,
      title: Text('test'),
    );
  }
}
