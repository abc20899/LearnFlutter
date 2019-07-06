import 'package:flutter/material.dart';
import 'package:flutter_first/bloc_demo_2/bloc_helpers/bloc_event_state_builder.dart';

import 'app_init_bloc.dart';
import 'app_init_event.dart';
import 'app_init_state.dart';

class InitializationPage extends StatefulWidget {
  @override
  _InitializationPageState createState() => _InitializationPageState();
}

class _InitializationPageState extends State<InitializationPage> {
  ApplicationInitializationBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ApplicationInitializationBloc();
    bloc.emitEvent(ApplicationInitializationEvent());
  }

  @override
  void dispose() {
    bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext pageContext) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: BlocEventStateBuilder<ApplicationInitializationEvent,
                ApplicationInitializationState>(
              bloc: bloc,
              builder:
                  (BuildContext context, ApplicationInitializationState state) {
                if (state.isInitialized) {
                  //
                  // Once the initialization is complete, let's move to another page
                  //
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushReplacementNamed('/home');
                  });
                }
                return Text('Initialization in progress... ${state.progress}%');
              },
            ),
          ),
        ),
      ),
    );
  }
}
