import 'package:flutter/material.dart';
import 'package:flutter_first/demo/base/main.dart';

main() => runApp(MyApp(
      barTitle: 'stepper',
      bodyWidget: StepWidget(),
    ));

class StepWidget extends StatefulWidget {
  @override
  _StepWidget createState() => _StepWidget();
}

class _StepWidget extends State<StepWidget> {
  int current_step = 0;
  List<Step> my_steps = [
    new Step(
        // Title of the Step
        title: new Text("Step 1"),
        // Content, it can be any widget here. Using basic Text for this example
        content: new Text("Hello!"),
        isActive: true),
    new Step(
        title: new Text("Step 2"),
        content: new Text("World!"),
        // You can change the style of the step icon i.e number, editing, etc.
        state: StepState.editing,
        isActive: true),
    new Step(
        title: new Text("Step 3"),
        content: new Text("Hello World!"),
        isActive: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stepper(
        steps: my_steps,
        currentStep: this.current_step,
        type: StepperType.vertical,
        onStepTapped: (step) {
          setState(() {
            current_step = step;
          });
          print("onStepTapped : " + step.toString());
        },
        onStepContinue: () {
          setState(() {
            if (current_step < my_steps.length - 1) {
              current_step = current_step + 1;
            } else {
              current_step = 0;
            }
          });
          print("onStepContinue : " + current_step.toString());
        },
        onStepCancel: () {
          setState(() {
            if (current_step > 0) {
              current_step = current_step - 1;
            } else {
              current_step = 0;
            }
          });
          print("onStepCancel : " + current_step.toString());
        },
      ),
    );
  }
}
