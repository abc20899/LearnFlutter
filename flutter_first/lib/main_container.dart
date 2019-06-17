import 'package:flutter/material.dart';
import 'dart:math' as math;

//容器类Widget和布局类Widget都作用于其子Widget，不同的是：
//布局类Widget一般都需要接收一个widget数组（children），他们直接或间接继承自（或包含）MultiChildRenderObjectWidget ；
// 而容器类Widget一般只需要接收一个子Widget（child），他们直接或间接继承自（或包含）SingleChildRenderObjectWidget。

//布局类Widget是按照一定的排列方式来对其子Widget进行排列；而容器类Widget一般只是包装其子Widget，对其添加一些修饰（补白或背景色等）、
// 变换(旋转或剪裁等)、或限制(大小等)。

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
        title: Text('容器类Widget学习'),
      ),
      body: TestContainer(),
    );
  }
}

//Padding
//fromLTRB(double left, double top, double right, double bottom)：分别指定四个方向的补白。
//all(double value) : 所有方向均使用相同数值的补白。
//only({left, top, right ,bottom })：可以设置具体某个方向的补白(可以同时指定多个方向)。
//symmetric({ vertical, horizontal })：用于设置对称方向的补白，vertical指top和bottom，horizontal指left和right。
class TestPadding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      //上下左右各添加16像素补白
      padding: EdgeInsets.all(16.0),
      child: Column(
        //显式指定对齐方式为左对齐，排除对齐干扰
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            //左边添加8像素补白
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("Hello world"),
          ),
          Padding(
            //上下各添加8像素补白
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text("I am Jack"),
          ),
          Padding(
            // 分别指定四个方向的补白
            padding: const EdgeInsets.fromLTRB(20.0, .0, 20.0, 20.0),
            child: Text("Your friend"),
          )
        ],
      ),
    );
  }
}

//ConstrainedBox用于对子widget添加额外的约束。例如，如果你想让子widget的最小高度是80像素，
// 你可以使用const BoxConstraints(minHeight: 80.0)作为子widget的约束。
class TestConstrainedBox extends StatelessWidget {
  Widget redBox = DecoratedBox(
    decoration: BoxDecoration(color: Colors.red),
  );

  @override
  Widget build(BuildContext context) {
    //我们实现一个最小高度为50，宽度尽可能大的红色容器。
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: double.infinity, //宽度尽可能大
        minHeight: 50.0, //最小高度为50像素
      ),
      child: Container(
        height: 5.0,
        child: redBox,
      ),
    );
  }
}
//可以看到，我们虽然将Container的高度设置为5像素，但是最终却是50像素，这正是ConstrainedBox的最小高度限制生效了。
//如果将Container的高度设置为80像素，那么最终红色区域的高度也会是80像素，因为在此示例中，ConstrainedBox只限制了最小高度，并未限制最大高度。

//BoxConstraints
//BoxConstraints.tight(Size size)，它可以生成给定大小的限制；
//const BoxConstraints.expand()可以生成一个尽可能大的用以填充另一个容器的BoxConstraints。

//SizedBox用于给子widget指定固定的宽高

//DecoratedBox可以在其子widget绘制前(或后)绘制一个装饰Decoration（如背景、边框、渐变等）
/**
 * BoxDecoration({
    Color color, //颜色
    DecorationImage image,//图片
    BoxBorder border, //边框
    BorderRadiusGeometry borderRadius, //圆角
    List<BoxShadow> boxShadow, //阴影,可以指定多个
    Gradient gradient, //渐变
    BlendMode backgroundBlendMode, //背景混合模式
    BoxShape shape = BoxShape.rectangle, //形状
    })
 * */

class TestDecoration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.red, Colors.orange[700]]),
            //背景渐变
            borderRadius: BorderRadius.circular(3.0),
            //3像素圆角
            boxShadow: [
              //阴影
              BoxShadow(
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0)
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
          child: Text(
            "Login",
            style: TextStyle(color: Colors.white),
          ),
        ));
  }
}

class TestTransform extends StatelessWidget {
  Widget xyTrans = DecoratedBox(
    decoration: BoxDecoration(color: Colors.red),
    //默认原点为左上角，左移20像素，向上平移5像素
    child: Transform.translate(
      offset: Offset(-20.0, -5.0),
      child: Text("Hello world"),
    ),
  );

  Widget marx = Container(
    color: Colors.black,
    child: new Transform(
      alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
      transform: new Matrix4.skewY(0.3), //沿Y轴倾斜0.3弧度
      child: new Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.deepOrange,
        child: const Text('Apartment for rent!'),
      ),
    ),
  );

  Widget ratate = DecoratedBox(
    decoration: BoxDecoration(color: Colors.red),
    child: Transform.rotate(
      //旋转90度
      angle: math.pi / 2,
      child: Text("Hello world"),
    ),
  );

  Widget scale = DecoratedBox(
      decoration: BoxDecoration(color: Colors.red),
      child: Transform.scale(
          scale: 1.5, //放大到1.5倍
          child: Text("Hello world")));

  @override
  Widget build(BuildContext context) {
    return Center(
      child: scale,
    );
  }
}
//Transform的变换是应用在绘制阶段，而并不是应用在布局(layout)阶段，所以无论对子widget应用何种变化，
// 其占用空间的大小和在屏幕上的位置都是固定不变的，因为这些是在布局阶段就确定的。

//RotatedBox和Transform.rotate功能相似，它们都可以对子widget进行旋转变换，
//但是有一点不同：RotatedBox的变换是在layout阶段，会影响在子widget的位置和大小。

//Container是我们要介绍的最后一个容器类widget，它本身不对应具体的RenderObject，
// 它是DecoratedBox、ConstrainedBox、Transform、Padding、Align等widget的一个组合widget。
// 所以我们只需通过一个Container可以实现同时需要装饰、变换、限制的场景。下面是Container的定义：
/**
 * Container({
    this.alignment,
    this.padding, //容器内补白，属于decoration的装饰范围
    Color color, // 背景色
    Decoration decoration, // 背景装饰
    Decoration foregroundDecoration, //前景装饰
    double width,//容器的宽度
    double height, //容器的高度
    BoxConstraints constraints, //容器大小的限制条件
    this.margin,//容器外补白，不属于decoration的装饰范围
    this.transform, //变换
    this.child,
    })
 * */
//容器的大小可以通过width、height属性来指定，也可以通过constraints来指定，如果同时存在时，width、height优先。
// 实际上Container内部会根据width、height来生成一个constraints。
//color和decoration是互斥的，实际上，当指定color时，Container内会自动创建一个decoration。
class TestContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50.0, left: 120.0),
      //容器外补白
      constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0),
      //卡片大小
      decoration: BoxDecoration(
          //背景装饰
          gradient: RadialGradient(
              //背景径向渐变
              colors: [Colors.red, Colors.orange],
              center: Alignment.topLeft,
              radius: .98),
          boxShadow: [
            //卡片阴影
            BoxShadow(
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0)
          ]),
      transform: Matrix4.rotationZ(.2),
      //卡片倾斜变换
      alignment: Alignment.center,
      //卡片内文字居中
      child: Text(
        //卡片文字
        "5.20", style: TextStyle(color: Colors.white, fontSize: 40.0),
      ),
    );
    ;
  }
}

//Padding和Margin
//Container内margin和padding都是通过Padding widget来实现的
/**
 * Container(
    margin: EdgeInsets.all(20.0), //容器外补白
    color: Colors.orange,
    child: Text("Hello world!"),
    ),

   Container(
    padding: EdgeInsets.all(20.0), //容器内补白
    color: Colors.orange,
    child: Text("Hello world!"),
    ),
 * */


































