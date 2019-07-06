import 'package:flutter_first/bloc_demo_2/bloc_helpers/bloc_event_state.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthenticationBloc
    extends BlocEventStateBase<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc()
      : super(
          initialState: AuthenticationState.notAuthenticated(),
        );

  @override
  Stream<AuthenticationState> eventHandler(
      AuthenticationEvent event, AuthenticationState currentState) async* {
    if (event is AuthenticationEventLogin) {
      //通知我们正在进行身份验证
      yield AuthenticationState.authenticating();

      //模拟对身份验证服务器的调用
      await Future.delayed(const Duration(seconds: 2));

      //告知我们是否已成功通过身份验证
      if (event.name == "failure") {
        yield AuthenticationState.failure();
      } else {
        yield AuthenticationState.authenticated(event.name);
      }
    }

    if (event is AuthenticationEventLogout) {
      yield AuthenticationState.notAuthenticated();
    }
  }
}
