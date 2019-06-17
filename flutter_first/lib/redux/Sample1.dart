import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

//1.新建一个数据共享类，也可以是基本数据类型，里面申明需要共享的数据
//2.创建枚举actions 用于消息区分
//3.申明一个方法用于处理数据更新逻辑与新的数据返回
//4.申明Store类，将步骤3的方法放进去
//5.在需要共享数据的地方申明StoreProvider跟布局，绑定Store类
//6.使用StoreConnector类或StoreBuilder处理数据逻辑与Widget交互逻辑

//StoreConnector主要是起一个数据转化的作用，可以在组件赋值之前做一些数据转化操作，而StoreBuilder是直接将共享的数据赋值在组件上，具体的选择看需求而定。
//StoreConnector有两个泛型参数，第一个是我们的原本的共享类型，第二个是我们需要转换的参数类型，它可以是类，方法，基本数据类型等都可以

//converter 起数据转化作用，例如源码中申明了一个String类型的转化参数，那么converter的返回值就是一个String类型，返回值会直接传递到builder方法的第二个参数中去。
//builder 接收数据，构建Widget交互，第一个context不需要解释，第二个参数就是我们申明的转化参数的返回值，返回值类型视传入的泛型类型而定。

void main() => runApp(Smaple1());

//1.数据共享类是state,一个基本数据类型
//3.
int reducer(int state, dynamic action) {
  if (action == Actions.Increment) {
    return state + 1;
  }
  return state;
}

//2.
enum Actions { Increment }

class Smaple1 extends StatelessWidget {
  //4. 申明一个store,必须传入一个方法进去，其余的参数选填，这里选择初始化一下基础参数
  final store = new Store<int>(reducer, initialState: 0);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store, //绑定store
      child: MaterialApp(
        theme: new ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(
            title: Text('test redux'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("You have pushed the button this many times:"),
                //当需要使用到共享数据的时候使用StoreConnector来获取数据
                StoreConnector<int, String>(
                    //返回widget
                    builder: (context, count) {
                      return Text(
                        count,
                        style: Theme.of(context).textTheme.display1,
                      );
                    },
                    //数据转换int ->string
                    converter: (store) => store.state.toString()),
              ],
            ),
          ),
          floatingActionButton: StoreConnector<int, VoidCallback>(
            //返回widget
            builder: (context, callback) {
              return FloatingActionButton(
                onPressed: callback,
                tooltip: 'asdasdasd',
                child: new Icon(Icons.add),
              );
            },
            converter: (store) {
              return () =>
                  store.dispatch(Actions.Increment); //发送数据 返回一个函数callback
            },
          ),
        ),
      ),
    );
  }
}
