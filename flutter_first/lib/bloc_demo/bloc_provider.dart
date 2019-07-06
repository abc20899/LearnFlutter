import 'package:flutter/material.dart';

//所有BLoC的通用接口
abstract class BlocBase {
  void dispose();
}

//通用BLoC提供者
class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({Key key, @required this.child, @required this.bloc})
      : super(key: key);

  final T bloc;

  final Widget child;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    //资源释放
    widget.bloc.dispose();
    super.dispose();
  }
}

//使用多个BLoC
//（如果有任何业务逻辑）每页顶部有一个BLoC，
//为什么不是ApplicationBloc来处理应用程序状态？
//每个“足够复杂的组件”都有相应的BLoC。

/**
 * void main() => runApp(
    BlocProvider<ApplicationBloc>(
    bloc: ApplicationBloc(),
    child: MyApp(),
    )
    );

    class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context){
    return MaterialApp(
    title: 'Streams Demo',
    home: BlocProvider<IncrementBloc>(
    bloc: IncrementBloc(),
    child: CounterPage(),
    ),
    );
    }
    }

    class CounterPage extends StatelessWidget {
    @override
    Widget build(BuildContext context){
    final IncrementBloc counterBloc = BlocProvider.of<IncrementBloc>(context);
    final ApplicationBloc appBloc = BlocProvider.of<ApplicationBloc>(context);
    ...
    }
    }
 * */
