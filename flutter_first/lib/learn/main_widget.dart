import 'package:flutter/material.dart';

void main() => runApp(TestApp());

//void main() => runApp(TestText());

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'test app',
      theme: ThemeData(primaryColor: Colors.blue),
//      home: new Echo(text: 'echo'),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Widget学习'),
      ),
      body: new FormTest(),
    );
  }
}

//文本控件测试
class TestText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: [
        new Text(
          'Hello world 文本',
          textAlign: TextAlign.center, //对齐方式
        ),
        new Text(
          'i am junechiu' * 6,
          maxLines: 1,
          overflow: TextOverflow.ellipsis, //超出省略
        ),
        new Text(
          'Hello World',
          textScaleFactor: 1.5, //缩放
        ),
        new Text(
          'Hello World',
          style: TextStyle(
              color: Colors.blue,
              fontSize: 18.0,
              height: 1.2,
              fontFamily: 'Courier',
              background: new Paint()..color = Colors.yellow,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dashed),
        ),
        Text.rich(
          TextSpan(//一个Text内容的不同部分按照不同的样式显示，这时就可以使用TextSpan
              children: [
            TextSpan(
              text: 'Home',
            ),
            TextSpan(
              text: "https://flutterchina.club",
              style: TextStyle(color: Colors.blue),
//                recognizer: _tapRecognizer //点击事件
            )
          ]),
        ),
        DefaultTextStyle(
          //在widget树中，文本的样式默认是可以被继承的
          //1.设置文本默认样式
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.red,
          ),
          textAlign: TextAlign.start,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("hello world"),
              Text("I am Jack"),
              Text(
                "I am Jack",
                style: TextStyle(
                    inherit: false, //2.不继承默认样式
                    color: Colors.grey),
              ),
            ],
          ),
        ),
        Text(
          //使用字体
          'Use the font for this text',
          style: TextStyle(
            fontFamily: 'DancingScript',
          ),
        ),
      ],
    );
  }
}

//按钮控件 Material widget库中提供了多种按钮Widget如RaisedButton、FlatButton、OutlineButton等，
// 它们都是直接或间接对RawMaterialButton的包装定制，所以他们大多数属性都和RawMaterialButton一样
class testButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Column(
      children: <Widget>[
        RaisedButton(
          //RaisedButton 即"漂浮"按钮，它默认带有阴影和灰色背景。按下后，阴影会变大
          child: Text('Nomal'),
          onPressed: () {},
        ),
        FlatButton(
          // FlatButton即扁平按钮，默认背景透明并不带阴影。按下后，会有背景色：
          child: Text('Nomal'),
          onPressed: () {},
        ),
        OutlineButton(
          // OutlineButton默认有一个边框，不带阴影且背景透明。按下后，边框颜色会变亮、同时出现背景和阴影(较弱)：
          child: Text('Nomal'),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.thumb_up),
          onPressed: () => {},
        ),
        FlatButton(
          //自定义按钮外观
          color: Colors.blue,
//          color: Color(0x000000), //去背景
          highlightColor: Colors.blue[700],
          colorBrightness: Brightness.dark,
          splashColor: Colors.grey,
          child: Text("Submit"),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          onPressed: () => {},
        ),
      ],
    ));
  }
}

//通过Image来加载并显示图片，Image的数据源可以是asset、文件、内存以及网络。
//AssetImage NetworkImage
/**
 * const Image({
    ...
    this.width, //图片的宽
    this.height, //图片高度
    this.color, //图片的混合色值
    this.colorBlendMode, //混合模式
    this.fit,//缩放模式
    fill：会拉伸填充满显示空间，图片本身长宽比会发生变化，图片会变形。
    cover：会按图片的长宽比放大后居中填满显示空间，图片不会变形，超出显示空间部分会被剪裁。
    contain：这是图片的默认适应规则，图片会在保证图片本身长宽比不变的情况下缩放以适应当前显示空间，图片不会变形。
    fitWidth：图片的宽度会缩放到显示空间的宽度，高度会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁。
    fitHeight：图片的高度会缩放到显示空间的高度，宽度会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁。
    none：图片没有适应策略，会在显示空间内显示图片，如果图片比显示空间大，则显示空间只会显示图片中间部分。

    this.alignment = Alignment.center, //对齐方式
    this.repeat = ImageRepeat.noRepeat, //重复方式
    ...
    })

    在Flutter开发中，iconfont和图片相比有如下优势：

    体积小：可以减小安装包大小。
    矢量的：iconfont都是矢量图标，放大不会影响其清晰度。
    可以应用文本样式：可以像文本一样改变字体图标的颜色、大小对齐等。
    可以通过TextSpan和文本混用。
 * */
class TestImage extends StatelessWidget {
  final String icon1 = "\uE914";
  final String icon2 = "\uE000";
  final String icon3 = "\uE90D";

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Column(
        children: <Widget>[
          Image(
              image: AssetImage("assets/images/wechat_icon.png"), width: 100.0),
          Image.asset(
            "assets/images/wechat_icon.png",
            width: 100.0,
          ),
          Image.network(
            "http://pic.baike.soso.com/p/20130917/20130917022419-1828768886.jpg",
            width: 100.0,
          ),
          Text(icon1,
              style: TextStyle(
                  fontFamily: "MaterialIcons",
                  fontSize: 24.0,
                  color: Colors.green)),
          Text(icon2,
              style: TextStyle(
                  fontFamily: "MaterialIcons",
                  fontSize: 24.0,
                  color: Colors.green)),
          Text(icon3,
              style: TextStyle(
                  fontFamily: "MaterialIcons",
                  fontSize: 24.0,
                  color: Colors.green)),
          Row(
            //Flutter封装了一个IconData和Icon来专门显示字体图标
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.accessible,
                color: Colors.green,
              ),
              Icon(
                Icons.error,
                color: Colors.green,
              ),
              Icon(
                Icons.fingerprint,
                color: Colors.green,
              ),
            ],
          )
        ],
      ),
    );
  }
}

//单选开关和复选框  Material风格的单选开关Switch和复选框Checkbox
//当用户点击Switch或Checkbox时，它们会触发onChanged回调，我们可以在此回调中处理选中状态改变逻辑
class TestSwitchCheck extends StatefulWidget {
  @override
  _TestSwitchCheckState createState() => new _TestSwitchCheckState();
}

class _TestSwitchCheckState extends State<TestSwitchCheck> {
  bool _switchSelected = true; //维护单选开关状态

  bool _checkboxSelected = true; //维护复选框状态

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Switch(
              value: _switchSelected,
              onChanged: (value) {
                setState(() {
                  _switchSelected = value;
                });
              }),
          Checkbox(
              value: _checkboxSelected,
              onChanged: (value) {
                setState(() {
                  _checkboxSelected = value;
                });
              })
        ],
      ),
    );
  }
}

//输入框及表单 TextField
//获取输入内容有两种方式：
//  定义两个变量，用于保存用户名和密码，然后在onChange触发时，各自保存一下输入内容。
//  通过controller直接获取。
//监听文本变化也有两种方式：
//  设置onChange回调，
//  通过controller监听，
class TestTextField extends StatelessWidget {
  //定义一个controller
  TextEditingController _unameController = new TextEditingController();

  @override
  void initState() {
    //监听输入改变
    _unameController.addListener(() {
      print(_unameController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          TextField(
            autofocus: true,
            controller: _unameController, //print(_unameController.text) 获取输入内容
            onChanged: (v) {
              //监听文本变换
              print(v);
            },
            decoration: InputDecoration(
              labelText: '用户名',
              hintText: '用户名或邮箱',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: '密码',
              hintText: '您的登录密码',
              prefixIcon: Icon(Icons.lock),
            ),
          ),
        ],
      ),
    );
  }
}

//焦点可以通过FocusNode和FocusScopeNode来控制，默认情况下，焦点由FocusScope来管理
class FocusTest extends StatefulWidget {
  @override
  _FocusTestState createState() => new _FocusTestState();
}

class _FocusTestState extends State<FocusTest> {
  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  FocusScopeNode focusScopeNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            autofocus: true,
            focusNode: focusNode1, //关联focusNode1
            decoration: InputDecoration(labelText: "input1"),
          ),
          TextField(
            focusNode: focusNode2, //关联focusNode2
            decoration: InputDecoration(labelText: "input2"),
          ),
          Builder(builder: (ctx) {
            return Column(
              children: <Widget>[
                RaisedButton(
                  child: Text("移动焦点"),
                  onPressed: () {
                    //将焦点从第一个TextField移到第二个TextField
                    // 这是一种写法 FocusScope.of(context).requestFocus(focusNode2);
                    // 这是第二种写法
                    if (null == focusScopeNode) {
                      focusScopeNode = FocusScope.of(context);
                    }
                    focusScopeNode.requestFocus(focusNode2);
                  },
                ),
                RaisedButton(
                  child: Text("隐藏键盘"),
                  onPressed: () {
                    // 当所有编辑框都失去焦点时键盘就会收起
                    focusNode1.unfocus();
                    focusNode2.unfocus();
                  },
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
//监听焦点状态改变事件
/**
 *创建 focusNode
    FocusNode focusNode = new FocusNode();
    ...
    focusNode绑定输入框
    TextField(focusNode: focusNode);
    ...
    监听焦点变化
    focusNode.addListener((){
    print(focusNode.hasFocus);
    });
 */

//表单Form Flutter提供了一个Form widget，它可以对输入框进行分组，然后进行一些统一操作，如输入内容校验、输入框重置以及输入内容保存。
class FormTest extends StatefulWidget {
  @override
  _FormTestState createState() => new _FormTestState();
}

class _FormTestState extends State<FormTest> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Form(
          key: _formKey, //设置globalKey，用于后面获取FormState
          autovalidate: true, //开启自动校验
          child: Column(
            children: <Widget>[
              TextFormField(
                  autofocus: true,
                  controller: _unameController,
                  decoration: InputDecoration(
                      labelText: "用户名",
                      hintText: "用户名或邮箱",
                      icon: Icon(Icons.person)),
                  // 校验用户名
                  validator: (v) {
                    return v.trim().length > 0 ? null : "用户名不能为空";
                  }),
              TextFormField(
                  controller: _pwdController,
                  decoration: InputDecoration(
                      labelText: "密码",
                      hintText: "您的登录密码",
                      icon: Icon(Icons.lock)),
                  obscureText: true,
                  //校验密码
                  validator: (v) {
                    return v.trim().length > 5 ? null : "密码不能少于6位";
                  }),
              //登录按钮
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                      padding: EdgeInsets.all(15.0),
                      child: Text("登录"),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        //在这里不能通过此方式获取FormState，context不对
                        //print(Form.of(context));
                        // 通过_formKey.currentState 获取FormState后，
                        // 调用validate()方法校验用户名密码是否合法，校验
                        // 通过后再提交数据。
                        if ((_formKey.currentState as FormState).validate()) {
                          //验证通过提交数据
                        }
                      },
                    ))
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class Echo extends StatelessWidget {
  const Echo({Key key, @required this.text, this.backgroundColor: Colors.grey})
      : super(key: key);

  final String text;

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: new Text(text),
      ),
    );
  }
}
