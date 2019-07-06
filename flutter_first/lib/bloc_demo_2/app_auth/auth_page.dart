import 'package:flutter/material.dart';
import 'package:flutter_first/bloc_demo_2/bloc_helpers/bloc_provider.dart';
import 'package:flutter_first/bloc_demo_2/bloc_helpers/bloc_event_state_builder.dart';

import 'auth_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthenticationPage extends StatelessWidget {
  /// Prevents the use of the "back" button
  Future<bool> _onWillPopScope() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Authentication Page'),
            leading: Container(),
          ),
          body: Container(
            child:
                BlocEventStateBuilder<AuthenticationEvent, AuthenticationState>(
              bloc: bloc,
              builder: (BuildContext context, AuthenticationState state) {
                if (state.isAuthenticating) {
//                  return PendingAction();
                }

                if (state.isAuthenticated) {
                  return Container();
                }

                List<Widget> children = <Widget>[];

                // Button to fake the authentication (success)
                children.add(
                  ListTile(
                    title: RaisedButton(
                      child: Text('Log in (success)'),
                      onPressed: () {
                        bloc.emitEvent(
                            AuthenticationEventLogin(name: 'Didier'));
                      },
                    ),
                  ),
                );

                // Button to fake the authentication (failure)
                children.add(
                  ListTile(
                    title: RaisedButton(
                      child: Text('Log in (failure)'),
                      onPressed: () {
                        bloc.emitEvent(
                            AuthenticationEventLogin(name: 'failure'));
                      },
                    ),
                  ),
                );

                // Display a text if the authentication failed
                if (state.hasFailed) {
                  children.add(
                    Text('Authentication failure!'),
                  );
                }

                return Column(
                  children: children,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
