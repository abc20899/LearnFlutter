import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() => runApp(MyApp()); //单行函数或方法的简

/**
 * Animation对象是Flutter动画库中的一个核心类，它生成指导动画的值。
    Animation对象知道动画的当前状态（例如，它是开始、停止还是向前或向后移动），但它不知道屏幕上显示的内容。
    AnimationController管理Animation。
    CurvedAnimation 将过程抽象为一个非线性曲线.
    Tween在正在执行动画的对象所使用的数据范围之间生成值。例如，Tween可能会生成从红到蓝之间的色值，或者从0到255。
    使用Listeners和StatusListeners监听动画状态改变。
 * */

class MyApp extends StatelessWidget {
  //根widget  应用本身也是一个widget
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animate', //应用名称
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ), //主题
      home: MyHomeRoutePage(), //应用首页路由
    );
  }
}

//首页
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  //动画对象
  Animation<double> animation;

  AnimationController controller;

  initState() {
    super.initState();

    //动画时间
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    //增值0--300
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() {
          //每次动画生成一个新的数字时都会调用build方法
        });
      });
    controller.forward(); //启动动画
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: new Container(
          margin: new EdgeInsets.symmetric(vertical: 10.0),
          height: animation.value, //动态改变大小
          width: animation.value,
          child: new FlutterLogo(),
        ),
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

//用AnimatedWidget简化  AnimatedWidget(基类)中会自动调用addListener()和setState()
/**
 * 如何使用AnimatedWidget助手类（而不是addListener()和setState()）来给widget添加动画
    使用AnimatedWidget创建一个可重用动画的widget。要从widget中分离出动画过渡，请使用AnimatedBuilder。
    Flutter API提供的关于AnimatedWidget的示例包括：AnimatedBuilder、AnimatedModalBarrier、DecoratedBoxTransition、
    FadeTransition、PositionedTransition、RelativePositionedTransition、RotationTransition、ScaleTransition、
    SizeTransition、SlideTransition。
 * */
class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Center(
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: new FlutterLogo(),
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  LogoApp({Key key, this.title}) : super(key: key);

  final String title;

  _LogoAppState createState() => new _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation<double> animation;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller);
    controller.forward();
  }

  Widget build(BuildContext context) {
    return new AnimatedLogo(animation: animation);
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

//监视动画的过程
//使用addStatusListener来处理动画状态更改的通知，例如启动、停止或反转方向。
//当动画完成或返回其开始状态时，通过反转方向来无限循环运行动画
class LogoApp2 extends StatefulWidget {
  LogoApp2({Key key, this.title}) : super(key: key);

  final String title;

  _LogoAppState2 createState() => new _LogoAppState2();
}

class _LogoAppState2 extends State<LogoApp2>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation<double> animation;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller);
    animation.addStatusListener((status) {
      print('status: $status');
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward(); //循环执行
      }
    });
    controller.forward();
  }

  Widget build(BuildContext context) {
    return new AnimatedLogo(animation: animation);
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

//用AnimatedBuilder重构  分离
//AnimatedBuilder了解如何渲染过渡.
//An AnimatedBuilder 不知道如何渲染widget，也不知道如何管理Animation对象。
//使用AnimatedBuilder将动画描述为另一个widget的build方法的一部分。如果你只是想用可复用的动画定义一个widget，请使用AnimatedWidget。
//Flutter API中AnimatedBuilder的示例包括: BottomSheet、ExpansionTile、 PopupMenu、ProgressIndicator、
// RefreshIndicator、Scaffold、SnackBar、TabBar、TextField。

class LogoWidget extends StatelessWidget {
  // Leave out the height and width so it fills the animating parent
  build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.symmetric(vertical: 10.0),
      child: new FlutterLogo(),
    );
  }
}

//动画widget
class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;

  final Animation<double> animation;

  Widget build(BuildContext context) {
    return new Center(
      child: new AnimatedBuilder(
          //动画
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return new Container(
                height: animation.value, width: animation.value, child: child);
          },
          child: child),
    );
  }
}

class LogoApp3 extends StatefulWidget {
  _LogoAppState3 createState() => new _LogoAppState3();
}

class _LogoAppState3 extends State<LogoApp3> with TickerProviderStateMixin {
  Animation animation;

  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    final CurvedAnimation curve =
        new CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = new Tween(begin: 0.0, end: 300.0).animate(curve);
    controller.forward();
  }

  Widget build(BuildContext context) {
    return new GrowTransition(child: new LogoWidget(), animation: animation);
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

//并行动画
//Curves 类定义常用动画曲线的数组，你可以通过CurvedAnimation 使用。
//在同一个动画控制器上使用多个Tween，其中每个Tween管理动画中的不同效果

class AnimatedLogo2 extends AnimatedWidget {
  // The Tweens are static because they don't change.
  static final _opacityTween = new Tween<double>(begin: 0.1, end: 1.0);
  static final _sizeTween = new Tween<double>(begin: 0.0, end: 300.0);

  AnimatedLogo2({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Center(
      child: new Opacity(
        opacity: _opacityTween.evaluate(animation),
        //.evaluate()在父级的动画对象上调用Tween函数以计算所需的size和opacity值。
        child: new Container(
          margin: new EdgeInsets.symmetric(vertical: 10.0),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: new FlutterLogo(),
        ),
      ),
    );
  }
}

class LogoApp4 extends StatefulWidget {
  _LogoAppState4 createState() => new _LogoAppState4();
}

class _LogoAppState4 extends State<LogoApp4> with TickerProviderStateMixin {
  AnimationController controller;

  Animation<double> animation;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.easeIn);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    controller.forward();
  }

  Widget build(BuildContext context) {
    return new AnimatedLogo2(animation: animation);
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

//自定义路由切换动画  可以使用PageRouteBuilder
class MyHomeRoutePage extends StatefulWidget {
  MyHomeRoutePage({Key key}) : super(key: key);

  @override
  _MyHomeRoutePageState createState() => _MyHomeRoutePageState();
}

class _MyHomeRoutePageState extends State<MyHomeRoutePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sss'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                //导航到新路由
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        //动画时间为500毫秒
                        pageBuilder: (BuildContext context, Animation animation,
                            Animation secondaryAnimation) {
                          return new FadeTransition(
                              //使用渐隐渐入过渡,
                              opacity: animation,
                              child: NewPage() //路由NewPage
                              );
                        }));
              },
              child: new Text('open new route'),
              textColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text('New Route'),
      ),
      body: new Center(
        child: new Text('this is a new page'),
      ),
    );
  }
}
