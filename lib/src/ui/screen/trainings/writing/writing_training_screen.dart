import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/screen/base_widget.dart';
import 'package:langvider/src/ui/screen/trainings/writing/writing_training_wm.dart';

class WritingTrainingScreen extends BaseWidget {
  @override
  BaseWidgetState buildState() => _WritingTrainingState();
}

class _WritingTrainingState
    extends BaseWidgetState<WritingTrainingScreen, WritingTrainingScreenWm> {
  @override
  Widget build(BuildContext context) => Scaffold(
        key: wm.scaffoldKey,
        body: const Center(child: Text('Писание')),
      );
}
