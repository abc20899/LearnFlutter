import 'package:flutter_first/bloc_demo_2/bloc_helpers/bloc_provider.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

abstract class BlocEvent extends Object {}

abstract class BlocState extends Object {}

abstract class BlocEventStateBase<BlocEvent, BlocState> implements BlocBase {
  PublishSubject<BlocEvent> _eventController = PublishSubject<BlocEvent>();

  BehaviorSubject<BlocState> _stateController = BehaviorSubject<BlocState>();

  /// 要调用以发出事件
  Function(BlocEvent) get emitEvent => _eventController.sink.add;

  /// 当前/新状态
  Stream<BlocState> get state => _stateController.stream;

  /// 事件的外部处理
  Stream<BlocState> eventHandler(BlocEvent event, BlocState currentState);

  /// initialState
  final BlocState initialState;

  // 构造函数
  BlocEventStateBase({
    @required this.initialState,
  }) {
    // 对于每个接收到的事件，我们调用[eventHandler]并发出任何结果的newState
    _eventController.listen((BlocEvent event) {
      BlocState currentState = _stateController.value ?? initialState;
      eventHandler(event, currentState).forEach((BlocState newState) {
        _stateController.sink.add(newState);
      });
    });
  }

  @override
  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
