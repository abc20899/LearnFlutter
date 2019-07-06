import 'package:flutter_first/bloc_demo_2/bloc_helpers/bloc_event_state.dart';

//class TemplateEventStateBloc extends BlocEventStateBase<BlocEvent, BlocState> {
//  TemplateEventStateBloc()
//      : super(
//    initialState: BlocState.notInitialized(),
//  );
//
//  @override
//  Stream<BlocState> eventHandler( BlocEvent event, BlocState currentState) async* {
//    yield BlocState.notInitialized();
//  }
//}

//使用async *修饰符标记函数，将函数标识为异步生成器：
//每次 yield 语句 被调用时，它增加了下面的表达式的结果 yield 输出stream。