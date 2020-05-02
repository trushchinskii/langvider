import 'package:flutter/material.dart';
import 'package:langvider/src/domain/training_type.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/screen/trainings/writing/writing_training_screen.dart';
import 'package:langvider/src/ui/screen/trainings/writing/writing_training_wm.dart';
import 'package:provider/provider.dart';

class WritingTrainingScreenRoute extends MaterialPageRoute<void> {
  WritingTrainingScreenRoute(TrainingType trainingType)
      : super(
          builder: (context) => _WritingTrainingScreenProvider(
            trainingType: trainingType,
            child: WritingTrainingScreen(),
          ),
        );
}

class _WritingTrainingScreenProvider extends Provider<WritingTrainingScreenWm> {
  _WritingTrainingScreenProvider({
    @required TrainingType trainingType,
    @required Widget child,
  }) : super(
          create: (context) => WritingTrainingScreenWm(
            WmDependencies(context, GlobalKey()),
            trainingType,
          ),
          child: child,
        );
}
