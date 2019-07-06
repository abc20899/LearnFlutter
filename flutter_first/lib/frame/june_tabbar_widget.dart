import 'package:flutter/material.dart';

class JuneTabBarWidget extends StatefulWidget {
  static const int TOP_BAR = 1;

  static const int BOTTOM_BAR = 2;

  final int type; //显示tab的位置

  final List<Widget> tabItems; //tab选项列表

  final List<Widget> tabViews; //page列表

  final Color backgroundColor; //选项背景颜色

  final Color indicatorColor; //选中颜色

  final Widget title;

  final Widget drawer; //抽屉

  final Widget floatingActionButton; //悬浮按钮

  final FloatingActionButtonLocation floatingActionButtonLocation;

  final TarWidgetControl tarWidgetControl;

  final ValueChanged<int> onPageChanged;

  final Widget bottomBar;

  final bool resizeToAvoidBottomPadding;

  JuneTabBarWidget(
      {Key key,
      this.type,
      this.tabItems,
      this.tabViews,
      this.backgroundColor,
      this.indicatorColor,
      this.title,
      this.drawer,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.tarWidgetControl,
      this.onPageChanged,
      this.bottomBar,
      this.resizeToAvoidBottomPadding = true})
      : super(key: key);

  @override
  _JuneTabBarWidgetState createState() => _JuneTabBarWidgetState(
      type,
      tabViews,
      indicatorColor,
      title,
      drawer,
      floatingActionButton,
      tarWidgetControl,
      onPageChanged);
}

class _JuneTabBarWidgetState extends State<JuneTabBarWidget>
    with SingleTickerProviderStateMixin {
  final int _type; //显示tab的位置

  final List<Widget> _tabViews; //page列表

  final Color _indicatorColor; //选中颜色

  final Widget _title;

  final Widget _drawer; //抽屉

  final Widget _floatingActionButton; //悬浮按钮

  final TarWidgetControl _tarWidgetControl;

  final PageController _pageController = PageController();

  final ValueChanged<int> _onPageChanged;

  _JuneTabBarWidgetState(
      this._type,
      this._tabViews,
      this._indicatorColor,
      this._title,
      this._drawer,
      this._floatingActionButton,
      this._tarWidgetControl,
      this._onPageChanged)
      : super();

  TabController _tabController; //tab控制器

  @override
  void initState() {
    //通过 with SingleTickerProviderStateMixin 实现动画效果。
    _tabController =
        new TabController(vsync: this, length: widget.tabItems.length);
    super.initState();
  }

  @override
  void dispose() {
    //页面销毁时，销毁控制器
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //顶部TAbBar模式
    if (this._type == JuneTabBarWidget.TOP_BAR) {
      return Scaffold(
        resizeToAvoidBottomPadding: widget.resizeToAvoidBottomPadding,
        floatingActionButton:
            SafeArea(child: _floatingActionButton ?? Container()),
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        persistentFooterButtons:
            _tarWidgetControl == null ? null : _tarWidgetControl.footerButton,
        //侧边滑出 drawer
        drawer: _drawer,
        //标题栏
        appBar: AppBar(
          title: _title,
          backgroundColor: Theme.of(context).primaryColor,
          bottom: TabBar(
            //顶部时，tabBar为可以滑动的模式
            isScrollable: true,
            //必须有的控制器，与pageView的控制器同步
            controller: _tabController,
            tabs: widget.tabItems,
            //tab底部选中条颜色
            indicatorColor: _indicatorColor,
            onTap: (index) {
              _onPageChanged?.call(index);
              _pageController.jumpTo(MediaQuery.of(context).size.width * index);
            },
          ),
        ),
        //页面主体，PageView，用于承载Tab对应的页面
        body: PageView(
          //必须有的控制器，与tabBar的控制器同步
          controller: _pageController,
          //每一个 tab 对应的页面主体，是一个List<Widget>
          children: _tabViews,
          //页面触摸作用滑动回调，用于同步tab选中状态
          onPageChanged: (index) {
            _tabController.animateTo(index);
            _onPageChanged?.call(index);
          },
        ),
        bottomNavigationBar: widget.bottomBar,
      );
    }
    //底部TAbBar模式
    return Scaffold(
      //侧边滑出 drawer
      drawer: _drawer,
      //标题栏
      appBar: AppBar(
        title: _title,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      //页面主体，PageView，用于承载Tab对应的页面
      body: PageView(
        controller: _pageController,
        children: _tabViews,
        //页面触摸作用滑动回调，用于同步tab选中状态
        onPageChanged: (index) {
          _tabController.animateTo(index);
          _onPageChanged?.call(index);
        },
      ),
      //底部导航栏，也就是tab栏
      bottomNavigationBar: Material(
        color: Theme.of(context).primaryColor, //底部导航栏主题颜色
        child: SafeArea(
            child: TabBar(
          controller: _tabController,
          tabs: widget.tabItems,
          indicatorColor: _indicatorColor, //tab底部选中条颜色
          onTap: (index) {
            _onPageChanged?.call(index);
            //pageController.jumpTo 跳转页面，每个页面需要跳转坐标为：当前屏幕大小乘以索引 index
            _pageController.jumpTo(MediaQuery.of(context).size.width * index);
          },
        )),
      ),
    );
  }
}

class TarWidgetControl {
  List<Widget> footerButton = [];
}
