import 'package:flutter_first/bloc_demo_2/bloc_helpers/bloc_event_state.dart';

import 'app_init_event.dart';
import 'app_init_state.dart';

class ApplicationInitializationBloc extends BlocEventStateBase<
    ApplicationInitializationEvent, ApplicationInitializationState> {
  ApplicationInitializationBloc()
      : super(
          initialState: ApplicationInitializationState.notInitialized(),
        );

  //事件操作 使用async *修饰符标记函数，将函数标识为异步生成器：
  //yield 语句 被调用时，它增加了下面的表达式的结果 yield 输出stream。
  @override
  Stream<ApplicationInitializationState> eventHandler(
      ApplicationInitializationEvent event,
      ApplicationInitializationState currentState) async* {
    if (!currentState.isInitialized) {
      yield ApplicationInitializationState.notInitialized();
    }

    if (event.type == ApplicationInitializationEventType.start) {
      for (int progress = 0; progress < 101; progress += 20) {
        await Future.delayed(const Duration(milliseconds: 100));
        yield ApplicationInitializationState.progressing(progress);
      }
    }

    if (event.type == ApplicationInitializationEventType.stop) {
      yield ApplicationInitializationState.initialized();
    }
  }
}
