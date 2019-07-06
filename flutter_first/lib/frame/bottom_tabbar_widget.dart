import 'package:flutter/material.dart';

import 'june_tabbar_widget.dart';
import 'page_first_widget.dart';

class BottomTabBarWidget extends StatefulWidget {
  @override
  _BottomTabBarWidgetState createState() => _BottomTabBarWidgetState();
}

class _BottomTabBarWidgetState extends State<BottomTabBarWidget> {
  final list = <String>['首页', '短视频', '发现', '我的'];

  _renderTabs() {
    List<Widget> tabItems = <Widget>[];
    for (int i = 0; i < list.length; i++) {
      tabItems.add(_tabItem(Icons.home, list[i]));
    }
    return tabItems;
  }

  _tabItem(icon, text) {
    return Tab(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 16.0,
          ),
          Text(text)
        ],
      ),
    );
  }

  _renderPages() {
    return [
      PageFirstWidget(),
      PageFirstWidget(),
      PageFirstWidget(),
      PageFirstWidget()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return JuneTabBarWidget(
      type: JuneTabBarWidget.BOTTOM_BAR,
      tabItems: _renderTabs(),
      tabViews: _renderPages(),
      indicatorColor: Theme.of(context).primaryColor,
      title: new Text("test"),
    );
  }
}
