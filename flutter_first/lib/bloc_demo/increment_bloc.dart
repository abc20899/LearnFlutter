import 'package:flutter/material.dart';
import 'bloc_provider.dart';
import 'dart:async';

class IncrementBloc extends BlocBase {
  int _counter;

  StreamController<int> _countController =
      StreamController<int>(); //Stream来处理计数器
  Stream<int> get outCounter => _countController.stream; //外部监听

  StreamController _actionController = StreamController(); //Stream来处理计数器上的操作
  StreamSink get incrementCounter => _actionController.sink; //外部操作发送数据

  IncrementBloc() {
    _counter = 0;
    _actionController.stream.listen(handleLogic); //Bloc内部监听
  }

  handleLogic(data) {
    _counter += 1;
    _countController.sink.add(_counter); //Bloc内部发送
  }

  @override
  void dispose() {
    _actionController.close();
    _countController.close();
  }
}
