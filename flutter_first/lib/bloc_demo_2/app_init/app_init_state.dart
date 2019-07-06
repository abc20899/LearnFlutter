import 'package:flutter_first/bloc_demo_2/bloc_helpers/bloc_event_state.dart';

class ApplicationInitializationState extends BlocState {
  final bool isInitialized;
  final bool isInitializing;
  final int progress;

  ApplicationInitializationState({
    this.isInitialized,
    this.isInitializing: false,
    this.progress: 0,
  });

  factory ApplicationInitializationState.notInitialized() {
    return ApplicationInitializationState(
      isInitialized: false,
    );
  }

  factory ApplicationInitializationState.progressing(int progress) {
    return ApplicationInitializationState(
      isInitialized: progress == 100,
      isInitializing: true,
      progress: progress,
    );
  }

  factory ApplicationInitializationState.initialized() {
    return ApplicationInitializationState(
      isInitialized: true,
      progress: 100,
    );
  }
}
