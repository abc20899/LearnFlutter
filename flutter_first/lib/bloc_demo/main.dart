import 'package:flutter/material.dart';

import 'bloc_provider.dart';
import 'increment_bloc.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MyApp',
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: BlocProvider<IncrementBloc>(
          bloc: IncrementBloc(),
          child: CounterPage(),
        ));
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IncrementBloc bloc = BlocProvider.of<IncrementBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('bloc'),
      ),
      body: Container(
        child: Center(
          child: StreamBuilder<int>(
              initialData: 0,
              stream: bloc.outCounter, //数据监听
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                return Text('You hit me: ${snapshot.data} times');
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.incrementCounter.add(null); //发送数据
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

//第一 是责任分离
//第二 可测试性
//第三 自由组织布局
//第四 减少“build”的次数
