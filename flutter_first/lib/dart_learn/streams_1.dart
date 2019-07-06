import 'dart:async';

void main() {
//  stream1();
  streamBroadcast();
}

void stream1() {
  //初始化“单订阅”流控制器
  StreamController ctrl = new StreamController();

  //初始化监听器
  StreamSubscription streamSubscription =
      ctrl.stream.listen((data) => print('$data'));

  //发送数据
  ctrl.sink.add('my name');
  ctrl.sink.add(1234);
  ctrl.sink.add({'a': 'element A', 'b': 'element B'});
  ctrl.sink.add(123.45);

  ctrl.close();
}

//“ 广播 ” 流
void streamBroadcast() {
  StreamController<int> ctrl = StreamController.broadcast();
  //监听器过滤数据
  StreamSubscription streamSubscription = ctrl.stream
      .where((value) => (value % 2 == 0))
      .listen((data) => print('$data'));
  for (int i = 0; i < 11; i++) {
    ctrl.sink.add(i);
  }
  ctrl.close();
}

/**
 * StreamSubscription - 当你不再需要监听Stream时，取消订阅;
    StreamController - 当你不再需要StreamController时，关闭它;
    这同样适用于RxDart主题，当你不再需要BehaviourSubject，PublishSubject ...时，请将其关闭。
 * */

//Flutter提供了一个非常方便的StatefulWidget，名为StreamBuilder。
//StreamBuilder监听Stream，每当某些数据输出Stream时，它会自动重建，调用其builder callback。
//因为实际调用setState（）方法的，会强制整个 Widget（和任何子小部件）重建。这里，
//只有StreamBuilder被重建（当然它的子部件，被streamBuilder包裹的子控件）

/**
 * Widgets 通过 Sinks 向 BLoC 发送事件(event)
    BLoC 通过流(stream)通知小部件(widgets)
    由BLoC实现的业务逻辑不是他们关注的问题。

    由于业务逻辑与UI的分离：
    我们可以随时更改业务逻辑，对应用程序的影响最小
    我们可能会更改UI而不会对业务逻辑产生任何影响，
    现在，测试业务逻辑变得更加容易。
 * */
