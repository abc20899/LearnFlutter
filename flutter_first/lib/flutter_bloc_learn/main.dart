///https://pub.dev/packages/flutter_bloc
///https://felangel.github.io/bloc/

///Bloc建立在RxDart之上;但是，它抽象了所有RxDart特定的实现细节。
///Events 是bloc的输入。通常会调度它们以响应用户交互，例如按钮按下或生命周期事件（如页面加载)
///States 是bloc的输出，代表了应用程序状态的一部分。可以基于当前状态向UI组件通知状态并重绘其自身的部分。
///Transitions 状态转换
///Bloc（业务逻辑组件）是将传入事件流转换为传出状态流的组件。将视为“大脑”。
///Streams 流是一系列异步数据
///BlocDelegate 接受bloc中的流程 在应用的其他地方监听

import 'package:bloc/bloc.dart';

//import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

void main() {
//  testStream();
  testBloc();
}

//////////////////////stream//////////////////////////
void testStream() async {
  Stream<int> stream = countStream(10);
//  stream.listen(print);
  int sum = await sumStream(stream);
  print(sum); // 45
}

///我们可以通过编写async *函数在Dart中创建Stream
///通过将函数标记为async *，我们可以使用yield关键字并返回数据流。在上面的例子中，我们返回一个整数流，直到最大整数参数
Stream<int> countStream(int max) async* {
  for (int i = 0; i < max; i++) {
    yield i;
  }
}

Future<int> sumStream(Stream<int> stream) async {
  int sum = 0;
  await for (int value in stream) {
    sum += value;
  }
  return sum;
}
///////////////////////////////////////Stream/////////////////////////////////////////////////////////

/////////////////////////////////////Bloc///////////////////////////////////////////////////////////
enum CounterEvent { increment, decrement }

///CounterBloc声明为一个Bloc，它将CounterEvents转换为int
///每个Bloc必须扩展基础Bloc类，它是核心bloc包的一部分
class CounterBloc extends Bloc<CounterEvent, int> {
  ///初始值需要设置
  @override
  int get initialState => 0;

  ///每个Bloc都必须实现一个名为mapEventToState的函数。该函数将传入事件作为参数，并且必须返回表示层使用的新状态流。
  ///我们可以使用currentState属性随时访问当前的bloc状态

  ///Blocs将忽略重复状态。如果Bloc产生stateState == state的State状态，则不会发生转换，也不会对Stream <State>进行任何更改

  ///每个bloc都有一个调度方法。Dispatch接受一个事件并触发mapEventToState。可以从表示层或从bloc内部调用调度，并向bloc通知新事件。
  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        yield currentState + 1;
        break;
      case CounterEvent.decrement:
        yield currentState - 1;
        break;
    }
  }

  ///onTransition是一种可以被覆盖以处理每个局部Bloc Transition的方法。在更新Bloc状态之前调用onTransition
  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    super.onTransition(transition);
    print(transition);
  }

  ///onError是一个可以重写以处理每个本地Bloc Exception的方法。默认情况下，将忽略所有异常，并且Bloc功能不受影响
  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    print('$error, $stacktrace');
  }
}

void testBloc() {
  ///绑定代理
  BlocSupervisor.delegate = SimpleBlocDelegate();
  CounterBloc bloc = CounterBloc();
  for (int i = 0; i < 3; i++) {
    bloc.dispatch(CounterEvent.increment);
  }
}

///BlocDelegate
class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }
}
/**
 * 事件转换
 * {
    "currentState": 0,
    "event": "CounterEvent.increment",
    "nextState": 1
    }
    {
    "currentState": 1,
    "event": "CounterEvent.increment",
    "nextState": 2
    }
    {
    "currentState": 2,
    "event": "CounterEvent.increment",
    "nextState": 3
    }
    Copy to clipboardErrorCopied

 * */
/////////////////////////////////////Bloc///////////////////////////////////////////////////////////
