import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart'; //引入 english_words包

void main() => runApp(TestApp());

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test app',
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldRoute();
  }
}

class ScaffoldRoute extends StatefulWidget {
  @override
  _ScaffoldRouteState createState() => _ScaffoldRouteState();
}

class _ScaffoldRouteState extends State<ScaffoldRoute> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //导航栏
        title: Text('App Name'), //左侧标题
        actions: <Widget>[
          //导航栏右侧菜单
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), title: Text('Business')),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), title: Text('School')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      body: ScrollNotificationTestRoute(),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAdd() {}
}

/**
 * Scrollable({
    this.axisDirection = AxisDirection.down,     滚动方向。
    this.controller,  此属性接受一个ScrollController对象。ScrollController的主要作用是控制滚动位置和监听滚动事件。
    this.physics,  physics：此属性接受一个ScrollPhysics对象 ClampingScrollPhysics：Android下微光效果。 BouncingScrollPhysics：iOS下弹性效果。
    @required this.viewportBuilder,
    })
 * */

class TestSingleChildScrollView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String str =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return Scrollbar(
        child: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          //动态创建一个List<Widget>
          children: str.split('').map((c) => Text(c)).toList(),
        ),
      ),
    ));
  }
}

/**
 * ListView({
    ...
    //可滚动widget公共参数
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController controller,
    bool primary,
    ScrollPhysics physics,
    EdgeInsetsGeometry padding,

    //ListView各个构造函数的共同参数
    double itemExtent,           itemExtent代表子widget的高度或者宽度
    bool shrinkWrap = false,     shrinkWrap：是否根据子widget的总长度来设置ListView的长度，默认值为false
    bool addAutomaticKeepAlives = true,   是否将列表项（子widget）包裹在AutomaticKeepAlive widget中；典型地，在一个懒加载列表中
    bool addRepaintBoundaries = true,    是否将列表项（子widget）包裹在RepaintBoundary中。当可滚动widget滚动时，将列表项包裹在RepaintBoundary中可以避免列表项重绘
    double cacheExtent,

    //子widget列表
    List<Widget> children = const <Widget>[],
    })
 * */

//默认构造函数有一个children参数，它接受一个Widget列表（List）。这种方式适合只有少量的子widget的情况，
// 因为这种方式需要将所有children都提前创建好（这需要做大量工作），而不是等到子widget真正显示的时候再创建。
class TestListView1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20.0),
      shrinkWrap: true,
      children: <Widget>[
        const Text('I\'m dedicating every day to you'),
        const Text('Domestic life was never quite my style'),
        const Text('When you smile, you knock me out, I fall apart'),
        const Text('And I thought I was so smart'),
      ],
    );
  }
}

//ListView.builder适合列表项比较多（或者无限）的情况，因为只有当子Widget真正显示的时候才会被创建。
/**
 * ListView.builder({
    // ListView公共参数已省略
    @required IndexedWidgetBuilder itemBuilder, 它是列表项的构建器，类型为IndexedWidgetBuilder，返回值为一个widget。
    当列表滚动到具体的index位置时，会调用该构建器构建列表项。

    int itemCount, 列表项的数量，如果为null，则为无限列表。
    })
 * */

class TestListView2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 100,
        itemExtent: 50.0, //子widget高度为50
        itemBuilder: (context, index) {
          return ListTile(title: Text("$index"));
        });
  }
}

//ListView.separated可以生成列表项之间的分割器
class TestListView3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //下划线widget预定义以供复用。
    Widget divider1 = Divider(
      color: Colors.blue,
      height: 0.5,
    );
    Widget divider2 = Divider(
      color: Colors.green,
      height: 0.5,
    );
    return ListView.separated(
      itemCount: 100,
      //列表项构造器
      itemBuilder: (BuildContext context, int index) {
        return ListTile(title: Text("$index"));
      },
      //分割器构造器
      separatorBuilder: (BuildContext context, int index) {
        return index % 2 == 0 ? divider1 : divider2;
      },
    );
  }
}

class InfiniteListView extends StatefulWidget {
  @override
  _InfiniteListViewState createState() => new _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  static const loadingTag = "##loading##"; //表尾标记
  var _words = <String>[loadingTag];

  @override
  void initState() {
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _words.length,
      itemBuilder: (context, index) {
        //如果到了表尾
        if (_words[index] == loadingTag) {
          //不足100条，继续获取数据
          if (_words.length - 1 < 100) {
            //获取数据
            _loadData();
            //加载时显示loading
            return Container(
              //返回加载子项
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: CircularProgressIndicator(strokeWidth: 2.0)),
            );
          } else {
            //已经加载了100条数据，不再获取数据。
            return Container(
                //返回加载完毕子项
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "没有更多了",
                  style: TextStyle(color: Colors.grey),
                ));
          }
        }
        //返回单词列表项
        return ListTile(title: Text(_words[index]));
      },
      separatorBuilder: (context, index) => Divider(height: .0),
    );
  }

  void _loadData() {
    //延时2秒添加数据
    Future.delayed(Duration(seconds: 2)).then((e) {
      _words.insertAll(
          _words.length - 1, //从哪个位置开始添加
          //每次生成20个单词
          generateWordPairs()
              .take(20)
              .map((e) => e.asPascalCase)
              .toList()); //转换为list
      setState(() {
        //重新构建列表
      });
    });
  }
}

//表头
class TestTitleListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('商品列表'),
        ),
        Expanded(
          child: ListView.builder(
              itemExtent: 44.0,
              itemCount: 100,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('$index'),
                );
              }),
        )
      ],
    );
  }
}

//GridView可以构建一个二维网格列表
/**
 *GridView({
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController controller,
    bool primary,
    ScrollPhysics physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry padding,
    @required SliverGridDelegate gridDelegate, //控制子widget layout的委托
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    double cacheExtent,
    List<Widget> children = const <Widget>[],
    })

    Flutter中提供了两个SliverGridDelegate的子类SliverGridDelegateWithFixedCrossAxisCount和SliverGridDelegateWithMaxCrossAxisExtent，
 */

class TestGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return GridView(
//        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//            crossAxisCount: 3, //横轴三个子widget
//            childAspectRatio: 1.0 //宽高比为1时，子widget
//            ),
//        children: <Widget>[
//          Icon(Icons.ac_unit),
//          Icon(Icons.airport_shuttle),
//          Icon(Icons.all_inclusive),
//          Icon(Icons.beach_access),
//          Icon(Icons.cake),
//          Icon(Icons.free_breakfast)
//        ]);
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1.0,
      children: <Widget>[
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast),
      ],
    );
  }
}

//SliverGridDelegateWithMaxCrossAxisExtent 该子类实现了一个横轴子元素为固定最大长度的layout算法
class TestGridView2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return GridView(
//      padding: EdgeInsets.zero,
//      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//        maxCrossAxisExtent: 100.0, //子元素在横轴上的最大长度
//        childAspectRatio: 2.0, //宽高比为2
//      ),
//      children: <Widget>[
//        Icon(Icons.ac_unit),
//        Icon(Icons.airport_shuttle),
//        Icon(Icons.all_inclusive),
//        Icon(Icons.beach_access),
//        Icon(Icons.cake),
//        Icon(Icons.free_breakfast),
//      ],
//    );
    return GridView.extent(
      maxCrossAxisExtent: 110.0,
      childAspectRatio: 2.0,
      children: <Widget>[
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast),
      ],
    );
  }
}

//GridView.builder来动态创建子Widget。
class InfiniteGridView extends StatefulWidget {
  @override
  _InfiniteGridViewState createState() => new _InfiniteGridViewState();
}

class _InfiniteGridViewState extends State<InfiniteGridView> {
  List<IconData> _icons = []; //保存Icon数据

  @override
  void initState() {
    // 初始化数据
    _retrieveIcons();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //每行三列
            childAspectRatio: 1.0 //显示区域宽高相等
            ),
        itemCount: _icons.length,
        itemBuilder: (context, index) {
          //如果显示到最后一个并且Icon总数小于200时继续获取数据
          if (index == _icons.length - 1 && _icons.length < 200) {
            _retrieveIcons();
          }
          return Icon(_icons[index]);
        });
  }

  //模拟异步获取数据
  void _retrieveIcons() {
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast
        ]);
      });
    });
  }
}

//CustomScrollView是可以使用sliver来自定义滚动模型（效果）的widget。它可以包含多种滚动模型，举个例子，
// 假设有一个页面，顶部需要一个GridView，底部需要一个ListView，而要求整个页面的滑动效果是统一的
class CustomScrollViewTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //因为本路由没有使用Scaffold，为了让子级Widget(如Text)使用
    //Material Design 默认的样式风格,我们使用Material作为本路由的根。
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          //AppBar，包含一个导航栏
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Demo'),
              background: Image.asset(
                "assets/images/wechat_icon.png",
                fit: BoxFit.cover,
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: new SliverGrid(
              //Grid
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //Grid按两列显示
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  //创建子widget
                  return new Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: new Text('grid item $index'),
                  );
                },
                childCount: 20,
              ),
            ),
          ),
          //List
          new SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              //创建列表项
              return new Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: new Text('list item $index'),
              );
            }, childCount: 50 //50个列表项
                ),
          ),
        ],
      ),
    );
  }
}

//ScrollController 滚动监听及控制
/**
 * ScrollController({
    double initialScrollOffset = 0.0, //初始滚动位置
    this.keepScrollOffset = true,//是否保存滚动位置
    })
    jumpTo(double offset)、animateTo(double offset,...)
    controller.addListener(()=>print(controller.offset))

 * */
class ScrollControllerTestRoute extends StatefulWidget {
  @override
  ScrollControllerTestRouteState createState() {
    return new ScrollControllerTestRouteState();
  }
}

class ScrollControllerTestRouteState extends State<ScrollControllerTestRoute> {
  ScrollController _controller = new ScrollController();
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  @override
  void initState() {
    //监听滚动事件，打印滚动位置
    _controller.addListener(() {
      print(_controller.offset); //打印滚动位置
      if (_controller.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("滚动控制")),
      body: Scrollbar(
        child: ListView.builder(
            itemCount: 100,
            itemExtent: 50.0, //列表项高度固定时，显式指定高度是一个好习惯(性能消耗小)
            controller: _controller,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("$index"),
              );
            }),
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                //返回到顶部时执行动画
                _controller.animateTo(.0,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.ease //动画曲线是Curves.ease
                    );
              }),
    );
  }
}

//滚动位置恢复 PageStorage是一个用于保存页面(路由)相关数据的Widget 子树中的Widget可以通过指定不同的PageStorageKey来存储各自的数据或状态。
//假设一个ScrollController同时被两个Scrollable Widget使用，那么我们可以通过如下方式分别读取他们的滚动位置
/**
 * controller.positions.elementAt(0).pixels
    controller.positions.elementAt(1).pixels
    controller.positions.length来确定controller被几个Scrollable Widget使用
 */

//监听ListView的滚动通知 NotificationListener是一个Widget
/**
 * 在接收到滚动事件时，参数类型为ScrollNotification，它包括一个metrics属性，它的类型是ScrollMetrics，该属性包含当前ViewPort及滚动位置等信息：
    pixels：当前滚动位置。
    maxScrollExtent：最大可滚动长度。
    extentBefore：滑出ViewPort顶部的长度；此示例中相当于顶部滑出屏幕上方的列表长度。
    extentInside：ViewPort内部长度；此示例中屏幕显示的列表部分的长度。
    extentAfter：列表中未滑入ViewPort部分的长度；此示例中列表底部未显示到屏幕范围部分的长度。
    atEdge：是否滑到了Scrollable Widget的边界（此示例中相当于列表顶或底部）。
 *
 * */
class ScrollNotificationTestRoute extends StatefulWidget {
  @override
  _ScrollNotificationTestRouteState createState() =>
      new _ScrollNotificationTestRouteState();
}

class _ScrollNotificationTestRouteState
    extends State<ScrollNotificationTestRoute> {
  String _progress = "0%"; //保存进度百分比

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      //进度条
      // 监听滚动通知
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          double progress = notification.metrics.pixels /
              notification.metrics.maxScrollExtent;
          //重新构建
          setState(() {
            _progress = "${(progress * 100).toInt()}%";
          });
          print("BottomEdge: ${notification.metrics.extentAfter == 0}");
          //return true; //放开此行注释后，进度条将失效
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ListView.builder(
                itemCount: 100,
                itemExtent: 50.0,
                itemBuilder: (context, index) {
                  return ListTile(title: Text("$index"));
                }),
            CircleAvatar(
              //显示进度百分比
              radius: 30.0,
              child: Text(_progress),
              backgroundColor: Colors.black54,
            )
          ],
        ),
      ),
    );
  }
}
