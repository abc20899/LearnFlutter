import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PullLoadWidget extends StatefulWidget {
  //
  final IndexedWidgetBuilder itemBuilder; //item渲染

  final RefreshCallback onLoadMore; //加载更多回调

  final RefreshCallback onRefresh; //下拉刷新回调

  final PullLoadWidgetControl control; //控制器，比如数据和一些配置

  //GlobalKey<RefreshIndicatorState> 对外提供 RefreshIndicator 的 RefreshIndicatorState，这样外部就
  // 可以通过 GlobalKey 调用 globalKey.currentState.show();，主动显示刷新状态并触发 onRefresh 。
  final Key refreshKey;

  PullLoadWidget(
      this.control, this.itemBuilder, this.onLoadMore, this.onRefresh,
      {this.refreshKey});

  @override
  _PullLoadWidgetState createState() => _PullLoadWidgetState(this.control,
      this.itemBuilder, this.onRefresh, this.onLoadMore, this.refreshKey);
}

class _PullLoadWidgetState extends State<PullLoadWidget> {
  //
  final IndexedWidgetBuilder itemBuilder;

  final RefreshCallback onLoadMore;

  final RefreshCallback onRefresh;

  final Key refreshKey;

  PullLoadWidgetControl control;

  //滚动监听
  final ScrollController _scrollController = new ScrollController();

  _PullLoadWidgetState(this.control, this.itemBuilder, this.onRefresh,
      this.onLoadMore, this.refreshKey);

  @override
  void initState() {
    //监听
    this.control.needLoadMore?.addListener(() {
      //延迟两秒等待确认
      try {
        Future.delayed(Duration(seconds: 2), () {
          _scrollController.notifyListeners();
        });
      } catch (e) {
        print(e);
      }
    });
    //滑动监听
    _scrollController.addListener(() {
      //是否滚动到底部
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (this.control.needLoadMore.value) {
          this.onLoadMore?.call(); //加载更多
        }
      }
    });
    super.initState();
  }

  ///根据配置状态返回实际列表数量
  ///实际上这里可以根据你的需要做更多的处理
  ///比如多个头部，是否需要空页面，是否需要显示加载更多。
  _getItemCount() {
    if (control.needHeader) {
      //如果需要头部，用Item 0 的 Widget 作为ListView的头部
      //列表数量大于0时，因为头部和底部加载更多选项，需要对列表数据总数+2
      return (control.dataList.length > 0)
          ? control.dataList.length + 2
          : control.dataList.length + 1;
    } else {
      ///如果不需要头部，在没有数据时，固定返回数量1用于空页面item呈现
      if (control.dataList.length == 0) {
        return 1;
      }

      ///如果有数据,因为有加载更多选项item，需要对列表数据总数+1
      return (control.dataList.length > 0)
          ? control.dataList.length + 1
          : control.dataList.length;
    }
  }

  ///根据配置状态返回实际列表渲染Item
  _getItem(int index) {
    if (!control.needHeader &&
        index == control.dataList.length &&
        control.dataList.length != 0) {
      ///如果不需要头部，并且数据不为0，当index等于数据长度时，渲染加载更多Item（因为index是从0开始）
      return _buildProgressIndicator();
    } else if (control.needHeader &&
        index == _getItemCount() - 1 &&
        control.dataList.length != 0) {
      ///如果需要头部，并且数据不为0，当index等于实际渲染长度 - 1时，渲染加载更多Item（因为index是从0开始）
      return _buildProgressIndicator();
    } else if (!control.needHeader && control.dataList.length == 0) {
      ///如果不需要头部，并且数据为0，渲染空页面
      return _buildEmpty();
    } else {
      ///回调外部正常渲染Item，如果这里有需要，可以直接返回相对位置的index
      return itemBuilder(context, index);
    }
  }

  ///上拉加载更多
  Widget _buildProgressIndicator() {
    ///是否需要显示上拉加载更多的loading
    Widget bottomWidget = (control.needLoadMore.value)
        ? new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                ///loading框
                new SpinKitRotatingCircle(
                    color: Theme.of(context).primaryColor),
                new Container(
                  width: 5.0,
                ),

                ///加载中文本
                new Text(
                  '正在加载更多',
                  style: TextStyle(
                    color: Color(0xFF121917),
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ])

        /// 不需要加载
        : new Container();
    return new Padding(
      padding: const EdgeInsets.all(20.0),
      child: new Center(
        child: bottomWidget,
      ),
    );
  }

  ///空页面
  Widget _buildEmpty() {
    return new Container(
      height: MediaQuery.of(context).size.height - 100,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {},
            child: new Image(
                image: new AssetImage('assets/images/lingjingru.jpeg'),
                width: 70.0,
                height: 70.0),
          ),
          Container(
            child: Text('目前什么也没有哟',
                style: TextStyle(fontSize: 18.0, color: Colors.black54)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        //GlobalKey，用户外部获取RefreshIndicator的State，做显示刷新
        key: refreshKey,
        child: ListView.builder(
          //保持ListView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
          physics: const AlwaysScrollableScrollPhysics(),
          //根据状态返回子项
          itemBuilder: (context, index) {
            return _getItem(index);
          },
          //根据状态返回数量
          itemCount: _getItemCount(),
          //滑动监听
          controller: _scrollController,
        ),

        ///下拉刷新触发，返回的是一个Future
        onRefresh: onRefresh);
  }
}

class PullLoadWidgetControl {
  ///数据，对齐增减，不能替换
  List dataList = new List();

  ///是否需要加载更多 通知
  ValueNotifier<bool> needLoadMore = new ValueNotifier(false);

  ///是否需要头部
  bool needHeader = false;
}
