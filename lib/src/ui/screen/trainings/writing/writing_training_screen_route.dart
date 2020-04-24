import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/screen/trainings/training_screen_type.dart';
import 'package:langvider/src/ui/screen/trainings/writing/writing_training_screen.dart';
import 'package:langvider/src/ui/screen/trainings/writing/writing_training_wm.dart';
import 'package:provider/provider.dart';

class WritingTrainingScreenRoute extends MaterialPageRoute<void> {
  WritingTrainingScreenRoute(TrainingScreenType screenType)
      : super(
          builder: (context) => _WritingTrainingScreenProvider(
            screenType: screenType,
            child: WritingTrainingScreen(),
          ),
        );
}

class _WritingTrainingScreenProvider extends Provider<WritingTrainingScreenWm> {
  _WritingTrainingScreenProvider({
    @required TrainingScreenType screenType,
    @required Widget child,
  }) : super(
          create: (context) => WritingTrainingScreenWm(
            WmDependencies(context, GlobalKey()),
            screenType,
          ),
          child: child,
        );
}
