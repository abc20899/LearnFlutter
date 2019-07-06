//全局单例BLoC
//可从应用程序的任何可能部分(例如，从不同页面)获得获得BLoC()
import 'package:rxdart/rxdart.dart';

class GlobalBloc {
  ///
  /// 与此BLoC相关的流
  ///
  BehaviorSubject<String> _controller = BehaviorSubject<String>();

  Function(String) get push => _controller.sink.add; //发送

  Stream<String> get stream => _controller; //监听

  ///
  /// Singleton工厂
  ///
  static final GlobalBloc _bloc = new GlobalBloc._internal();

  factory GlobalBloc() {
    return _bloc;
  }

  GlobalBloc._internal();

  ///
  /// Resource disposal
  ///
  void dispose() {
    _controller?.close();
  }
}

GlobalBloc globalBloc = GlobalBloc();
