//使用
import 'package:flutter/cupertino.dart';
import 'package:flutter_first/bloc_demo_2/global_block/global_bloc.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    globalBloc.push('building MyWidget');
    return Container();
  }
}

//这是非常容易使用;
//它不依赖于任何BuildContext;
//没有必要通过任何BlocProvider去寻找 BLoC;
//为了释放它的资源，只需确保将应用程序实现为StatefulWidget，并在应用程序Widget 的重写dispose（）方法中调用globalBloc.dispose（）

//如果您需要在应用程序中的任何位置使用BLoC，则必须将其作为MaterialApp的父级，如下所示：
/**
 * void main() => runApp(Application());
    class Application extends StatelessWidget {
         @override
         Widget build(BuildContext context) {
              return BlocProvider<AuthenticationBloc>(
                       bloc: AuthenticationBloc(),
                       child: MaterialApp(
                       title: 'BLoC Samples',
                       theme: ThemeData(
                         primarySwatch: Colors.blue,
                       ),
                       home: InitializationPage(),
                     ),
             );
        }
    }
 * */

//每次重建时实例化BLoC。
//后果：
//您将丢失任何现有的BLoC内容
//它会耗费CPU时间，因为它需要在每次构建时实例化它。

/**
 * class MyTree extends StatefulWidget {
    @override
    _MyTreeState createState() => _MyTreeState();
    }
    class _MyTreeState extends State<MyTree>{
       MyBloc bloc;

      @override
      void initState(){
         super.initState();
         bloc = MyBloc();
      }

      @override
      void dispose(){
         bloc?.dispose();
         super.dispose();
      }

      @override
      Widget build(BuildContext context){
        return BlocProvider<MyBloc>(
          bloc: bloc,
            child: Column(
              children: <Widget>[
              MyChildWidget(),
            ],
          ),
        );
      }
    }
    使用这种方法，如果需要重建“ MyTree ”小部件，则不必重新实例化BLoC并直接重用现有实例。
 * */


