import 'package:flutter/material.dart';

//StatelessWidget和StatefulWidget就是两个用于组合Widget的基类，它们本身并不关联最终的渲染对象（RenderObjectWidget）。
//布局类Widget就是指直接或间接继承(包含)MultiChildRenderObjectWidget的Widget，它们一般都会有一个children属性用于接收子Widget。
// 我们看一下继承关系 Widget > RenderObjectWidget > (Leaf/SingleChild/MultiChild)RenderObjectWidget 。
// RenderObjectWidget类中定义了创建、更新RenderObject的方法，子类必须实现他们，关于RenderObject我们现在只需要知道它是最终布局、
// 渲染UI界面的对象即可，也就是说，对于布局类Widget来说，其布局算法都是通过对应的RenderObject对象来实现的

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
    return Scaffold(
      appBar: AppBar(
        title: Text('layout学习'),
      ),
      body: TestStack(),
    );
  }
}

//Flutter中通过Row和Column来实现线性布局，类似于Android中的LinearLayout控件。Row和Column都继承自Flex
/**
 *Row({
    TextDirection textDirection,        表示水平方向子widget的布局顺序(是从左往右还是从右往左)
    MainAxisSize mainAxisSize = MainAxisSize.max,   表示Row在主轴(水平)方向占用的空间
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start, 表示子Widgets在Row所占用的水平空间内对齐方式

    VerticalDirection verticalDirection = VerticalDirection.down, 表示Row纵轴（垂直）的对齐方向，默认是VerticalDirection.down，
    表示从上到下。

    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    表示子Widgets在纵轴方向的对齐方式，Row的高度等于子Widgets中最高的子元素高度，
    它的取值和MainAxisAlignment一样(包含start、end、 center三个值)，不同的是crossAxisAlignment的参考系是verticalDirection，
    即verticalDirection值为VerticalDirection.down时crossAxisAlignment.start指顶部对齐，verticalDirection值为VerticalDirection.up时，
    crossAxisAlignment.start指底部对齐；而crossAxisAlignment.end和crossAxisAlignment.start正好相反；

    List<Widget> children = const <Widget>[],
    })
 */
class LinearLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      //测试Row对齐方式，排除Column默认居中对齐的干扰
      crossAxisAlignment: CrossAxisAlignment.start, //顶部对齐
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center, //居中对齐
          children: <Widget>[
            Text('Hello world'),
            Text('i am jack'),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min, //Row的宽度等于两个Text的宽度和，所以对齐是无意义的
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('hello world'),
            Text('i am jack'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          textDirection: TextDirection.rtl,
          //Row设置textDirection值为TextDirection.rtl，所以子widget会从右向左的顺序排列
          children: <Widget>[
            Text('hello world'),
            Text('i am jack'),
          ],
        ),
        Row(
          //Row测试的是纵轴的对齐方式，由于两个子Text字体不一样，所以其高度也不同，我们指定了verticalDirection值为VerticalDirection.up，
          // 即从低向顶排列，而此时crossAxisAlignment值为CrossAxisAlignment.start表示底对齐。
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.up,
          children: <Widget>[
            Text('hello world', style: TextStyle(fontSize: 30.0)),
            Text('i am jack'),
          ],
        )
      ],
    );
  }
}

class TestContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      padding: EdgeInsets.all(16.0), //内边距
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max, //有效，外层Colum高度为整个屏幕
        children: <Widget>[
          Expanded(
            child: Container(
              //如果要让里面的Column占满外部Column，可以使用Expanded widget
              color: Colors.red,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text("hello world "),
                  Text("I am Jack "),
                ],
              ),
            ),
          )
//          Container(   //如果要让里面的Column占满外部Column，可以使用Expanded widget
//            color: Colors.red,
//            child: Column(
//              mainAxisSize: MainAxisSize.max,
//              children: <Widget>[
//                Text("hello world "),
//                Text("I am Jack "),
//              ],
//            ),
//          )
        ],
      ),
    );
  }
}

class FlexLayoutTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flex(
          direction: Axis.horizontal, //横向布局
          children: <Widget>[
            Expanded(
                flex: 1, //占据空间的 1
                child: Container(
                  color: Colors.red,
                  height: 30.0,
                )),
            Expanded(
                flex: 2, //占据空间的 2
                child: Container(
                  color: Colors.green,
                  height: 30.0,
                ))
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: SizedBox(
            height: 100.0,
            //Flex的三个子widget，在垂直方向按2：1：1来占用100像素的空间
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 30.0,
                    color: Colors.red,
                  ),
                ),
                Spacer(
                  //Spacer的功能是占用指定比例的空
                  flex: 1,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 30.0,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

//Flutter中通过Wrap和Flow来支持流式布局 内容溢出自动折行
/**
 * spacing：主轴方向子widget的间距
    runSpacing：纵轴方向的间距
    runAlignment：纵轴方向的对齐方式
 */
class TestWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // 主轴(水平)方向间距
      runSpacing: 4.0, // 纵轴（垂直）方向间距
      alignment: WrapAlignment.center, //沿主轴方向居中
      children: <Widget>[
        new Chip(
          avatar:
              new CircleAvatar(backgroundColor: Colors.blue, child: Text('A')),
          label: new Text('Hamilton'),
        ),
        new Chip(
          avatar:
              new CircleAvatar(backgroundColor: Colors.blue, child: Text('M')),
          label: new Text('Lafayette'),
        ),
        new Chip(
          avatar:
              new CircleAvatar(backgroundColor: Colors.blue, child: Text('H')),
          label: new Text('Mulligan'),
        ),
        new Chip(
          avatar:
              new CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
          label: new Text('Laurens'),
        ),
      ],
    );
  }
}

/**
 * 性能好；Flow是一个对child尺寸以及位置调整非常高效的控件，Flow用转换矩阵（transformation matrices）
 * 在对child进行位置调整的时候进行了优化：在Flow定位过后，如果child的尺寸或者位置发生了变化，
 * 在FlowDelegate中的paintChildren()方法中调用context.paintChild 进行重绘，
 * 而context.paintChild在重绘时使用了转换矩阵（transformation matrices），并没有实际调整Widget位置。

    灵活；由于我们需要自己实现FlowDelegate的paintChildren()方法，所以我们需要自己计算每一个widget的位置，因此，可以自定义布局策略。
 * */
class TestFlow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0)),
      children: <Widget>[
        new Container(
          width: 80.0,
          height: 80.0,
          color: Colors.red,
        ),
        new Container(
          width: 80.0,
          height: 80.0,
          color: Colors.green,
        ),
        new Container(
          width: 80.0,
          height: 80.0,
          color: Colors.blue,
        ),
        new Container(
          width: 80.0,
          height: 80.0,
          color: Colors.yellow,
        ),
        new Container(
          width: 80.0,
          height: 80.0,
          color: Colors.brown,
        ),
        new Container(
          width: 80.0,
          height: 80.0,
          color: Colors.purple,
        ),
      ],
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;

  TestFlowDelegate({this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  getSize(BoxConstraints constraints) {
    //指定Flow的大小
    return Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}

/**
 * 由于第一个子widget Text("Hello world")没有指定定位，并且alignment值为Alignment.center，所以，
 * 它会居中显示。第二个子widget Text("I am Jack")只指定了水平方向的定位(left)，所以属于部分定位，
 * 即垂直方向上没有定位，那么它在垂直方向对齐方式则会按照alignment指定的对齐方式对齐，即垂直方向居中。
 * 对于第三个子widget Text("Your friend")，和第二个Text原理一样，只不过是水平方向没有定位，则水平方向居中。
 * */
class TestPositioned extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
        children: <Widget>[
          Container(
            child: Text("Hello world", style: TextStyle(color: Colors.white)),
            color: Colors.red,
          ),
          Positioned(
            left: 18.0,
            child: Text("I am Jack"),
          ),
          Positioned(
            top: 18.0,
            child: Text("Your friend"),
          )
        ],
      ),
    );
    ;
  }
}

/**
 * 可以看到，由于第二个子widget没有定位，所以fit属性会对它起作用，就会占满Stack。有Stack子元素是堆叠的，
 * 所以第一个子Widget被第二个遮住了，而第三个在最上层，所以可以正常显示。
 * */
class TestStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand, //未定位widget占满Stack整个空间
      children: <Widget>[
        Positioned(
          left: 18.0,
          child: Text("I am Jack"),
        ),
        Container(
          child: Text("Hello world", style: TextStyle(color: Colors.white)),
          color: Colors.red,
        ),
        Positioned(
          top: 18.0,
          child: Text("Your friend"),
        )
      ],
    );
  }
}


/**
 *
 *
 * */





























