import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() => runApp(TestApp());

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'test app',
      theme: ThemeData(primaryColor: Colors.blue),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('事件处理Widget'),
      ),
      body: GestureConflictTestRoute(),
    );
  }
}

//Pointer事件处理 Flutter中可以使用Listener widget来监听原始触摸事件，它也是一个功能性widget。
/**
 * Listener({
    Key key,
    this.onPointerDown, //手指按下回调
    this.onPointerMove, //手指移动回调
    this.onPointerUp,//手指抬起回调
    this.onPointerCancel,//触摸事件取消回调
    this.behavior = HitTestBehavior.deferToChild, //在命中测试期间如何表现
    Widget child
    })

    PointerDownEvent
    position：它是鼠标相对于当对于全局坐标的偏移。
    delta：两次指针移动事件（PointerMoveEvent）的距离。
    pressure：按压力度，如果手机屏幕支持压力传感器(如iPhone的3D Touch)，此属性会更有意义，如果手机不支持，则始终为1。
    orientation：指针移动方向，是一个角度值。
 * */

class TestPointEvent extends StatefulWidget {
  @override
  _TestPointEventState createState() => _TestPointEventState();
}

class _TestPointEventState extends State<TestPointEvent> {
  //定义一个状态，保存当前指针位置
  PointerEvent _event;

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: Container(
        alignment: Alignment.center,
        color: Colors.green,
        width: 300.0,
        height: 150.0,
        child: Text(_event?.toString() ?? "",
            style: TextStyle(color: Colors.white)),
      ),
      onPointerDown: (PointerDownEvent event) => setState(() => _event = event),
      onPointerMove: (PointerMoveEvent event) => setState(() => _event = event),
      onPointerUp: (PointerUpEvent event) => setState(() => _event = event),
    );
  }
}

//behavior属性，它决定子Widget如何响应命中测试，它的值类型为HitTestBehavior，这是一个枚举类，有三个枚举值
//deferToChild：子widget会一个接一个的进行命中测试，如果子Widget中有测试通过的，则当前Widget通过，这就意味着，
//  如果指针事件作用于子Widget上时，其父(祖先)Widget也肯定可以收到该事件。
//opaque：在命中测试时，最终的效果相当于当前Widget的整个区域都是点击区域。
//translucent：当点击Widget透明区域时，可以对自身边界内及底部可视区域都进行命中测试，
// 这意味着点击顶部widget透明区域时，顶部widget和底部widget都可以接收到事件

class TestPointEventBehavior extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Listener(
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(300.0, 200.0)),
            child: DecoratedBox(decoration: BoxDecoration(color: Colors.blue)),
          ),
          onPointerDown: (event) => print("down0"),
        ),
        Listener(
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(200.0, 100.0)),
            child: Center(child: Text("左上角200*100范围内非文本区域点击")),
          ),
          onPointerDown: (event) => print("down1"),
//          behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
          //如果behavior值改为HitTestBehavior.opaque，则只会打印"down1"。
        )
      ],
    );
  }
}

//忽略PointerEvent
//假如我们不想让某个子树响应PointerEvent的话，我们可以使用IgnorePointer和AbsorbPointer，这两个Widget都能阻止子树接收指针事件，
// 不同之处在于AbsorbPointer本身会参与命中测试，而IgnorePointer本身不会参与，这就意味着AbsorbPointer本身是可以接收指针事件的(但其子树不行)，而IgnorePointer不可以

//GestureDetector是一个用于手势识别的功能性Widget，我们通过它可以来识别各种手势，它是指针事件的语义化封装
class GestureDetectorTestRoute extends StatefulWidget {
  @override
  _GestureDetectorTestRouteState createState() =>
      new _GestureDetectorTestRouteState();
}

class _GestureDetectorTestRouteState extends State<GestureDetectorTestRoute> {
  String _operation = "No Gesture detected!"; //保存事件名
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 200.0,
          height: 100.0,
          child: Text(
            _operation,
            style: TextStyle(color: Colors.white),
          ),
        ),
        onTap: () => updateText("Tap"), //点击
        onDoubleTap: () => updateText("DoubleTap"), //双击
        onLongPress: () => updateText("LongPress"), //长按
      ),
    );
  }

  void updateText(String text) {
    //更新显示的事件名
    setState(() {
      _operation = text;
    });
  }
}

//DragDownDetails.globalPosition：当用户按下时，此属性为用户按下的位置相对于屏幕(而非父widget)原点(左上角)的偏移。
//DragUpdateDetails.delta：当用户在屏幕上滑动时，会触发多次Update事件，delta指一次Update事件的滑动的偏移量。
//DragEndDetails.velocity：该属性代表用户抬起手指时的滑动速度(包含x、y两个轴的），示例中并没有处理手指抬起时的速度，
// 常见的效果是根据用户抬起手指时的速度做一个减速动画。
class _Drag extends StatefulWidget {
  @override
  _DragState createState() => new _DragState();
}

class _DragState extends State<_Drag> with SingleTickerProviderStateMixin {
  double _top = 0.0; //距顶部的偏移
  double _left = 0.0; //距左边的偏移

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text("A")),
            //手指按下时会触发此回调
            onPanDown: (DragDownDetails e) {
              //打印手指按下的位置(相对于屏幕)
              print("用户手指按下：${e.globalPosition}");
            },
            //手指滑动时会触发此回调
            onPanUpdate: (DragUpdateDetails e) {
              //用户手指滑动时，更新偏移，重新构建
              setState(() {
                _left += e.delta.dx;
                _top += e.delta.dy;
              });
            },
            onPanEnd: (DragEndDetails e) {
              //打印滑动结束时在x、y轴上的速度
              print(e.velocity);
            },
          ),
        )
      ],
    );
  }
}

//单一方向拖动
class _DragVertical extends StatefulWidget {
  @override
  _DragVerticalState createState() => new _DragVerticalState();
}

class _DragVerticalState extends State<_DragVertical> {
  double _top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          child: GestureDetector(
              child: CircleAvatar(child: Text("A")),
              //垂直方向拖动事件
              onVerticalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _top += details.delta.dy;
                });
              }),
        )
      ],
    );
  }
}

//缩放
class ScaleTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScaleTestRouteState();
  }
}

class _ScaleTestRouteState extends State<ScaleTestRoute> {
  double _width = 200.0; //通过修改图片宽度来达到缩放效果

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        //指定宽度，高度自适应
        child: Image.asset("assets/images/lingjingru.jpeg", width: _width),
        onScaleUpdate: (ScaleUpdateDetails details) {
          setState(() {
            //缩放倍数在0.8到10倍之间
            _width = 200 * details.scale.clamp(.8, 10.0);
          });
        },
      ),
    );
  }
}

//GestureRecognizer的作用就是通过Listener来将原始指针事件转换为语义手势
// TextSpan有一个recognizer属性，它可以接收一个GestureRecognizer
class GestureRecognizerTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GestureRecognizerTestRouteState();
  }
}

class _GestureRecognizerTestRouteState extends State<GestureRecognizerTest> {
  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();

  bool _toggle = false; //变色开关

  @override
  void dispose() {
    //用到GestureRecognizer的话一定要调用其dispose方法释放资源
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(TextSpan(children: [
        TextSpan(text: "你好世界"),
        TextSpan(
          text: "点我变色",
          style: TextStyle(
              fontSize: 30.0, color: _toggle ? Colors.blue : Colors.red),
          recognizer: _tapGestureRecognizer
            ..onTap = () {
              setState(() {
                _toggle = !_toggle;
              });
            },
        ),
        TextSpan(text: "你好世界"),
      ])),
    );
  }
}

//手势冲突
// 手势冲突只是手势级别的，而手势是对原始指针的语义化的识别，所以在遇到复杂的冲突场景时，都可以通过Listener直接识别原始指针事件来解决冲突。
class GestureConflictTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GestureConflictTestRouteState2();
  }
}

class GestureConflictTestRouteState extends State<GestureConflictTestRoute> {
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text("A")),
            //要拖动和点击的widget
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _left += details.delta.dx;
              });
            },
            onHorizontalDragEnd: (details) {
              print("onHorizontalDragEnd");
            },
            onTapDown: (details) {
              print("down");
            },
            onTapUp: (details) {
              print("up");
            },
          ),
        )
      ],
    );
  }
}

//我们发现没有打印"up"，这是因为在拖动时，刚开始按下手指时在没有移动时，拖动手势还没有完整的语义，此时TapDown手势胜出(win)，
// 此时打印"down"，而拖动时，拖动手势会胜出，当手指抬起时，onHorizontalDragEnd 和 onTapUp发生了冲突，但是因为是在拖动的语义中，
// 所以onHorizontalDragEnd胜出，所以就会打印 “onHorizontalDragEnd”。如果我们的代码逻辑中，对于手指按下和抬起是强依赖的，
// 比如在一个轮播图组件中，我们希望手指按下时，暂停轮播，而抬起时恢复轮播，但是由于轮播图组件中本身可能已经处理了拖动手势
// （支持手动滑动切换），甚至可能也支持了缩放手势，这时我们如果在外部再用onTapDown、onTapUp来监听的话是不行的。
// 这时我们应该怎么做？其实很简单，通过Listener监听原始指针事件就行：

class GestureConflictTestRouteState2 extends State<GestureConflictTestRoute> {
  double _leftB = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 80.0,
          left: _leftB,
          child: Listener(
            onPointerDown: (details) {
              print("down");
            },
            onPointerUp: (details) {
              //会触发
              print("up");
            },
            child: GestureDetector(
              child: CircleAvatar(child: Text("B")),
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _leftB += details.delta.dx;
                });
              },
              onHorizontalDragEnd: (details) {
                print("onHorizontalDragEnd");
              },
            ),
          ),
        )
      ],
    );
  }
}
