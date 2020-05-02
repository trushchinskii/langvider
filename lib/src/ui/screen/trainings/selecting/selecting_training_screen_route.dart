import 'package:flutter/material.dart';
import 'package:langvider/src/domain/training_type.dart';
import 'package:langvider/src/interactor/training/training_interactor.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/screen/trainings/selecting/selecting_training_screen.dart';
import 'package:langvider/src/ui/screen/trainings/selecting/selecting_training_wm.dart';
import 'package:langvider/src/ui/utils/provider_utils.dart';
import 'package:provider/provider.dart';

class SelectingTrainingScreenRoute extends MaterialPageRoute<void> {
  SelectingTrainingScreenRoute(TrainingType trainingType)
      : super(
          builder: (context) => _SelectingTrainingScreenProvider(
            trainingType: trainingType,
            child: SelectingTrainingScreen(screenType: trainingType),
          ),
        );
}

class _SelectingTrainingScreenProvider
    extends Provider<SelectingTrainingScreenWm> {
  _SelectingTrainingScreenProvider({
    @required TrainingType trainingType,
    @required Widget child,
  }) : super(
          create: (context) => SelectingTrainingScreenWm(
            WmDependencies(context, GlobalKey()),
            trainingType,
            ProviderUtils.provide<TrainingInteractor>(context),
          ),
          child: child,
        );
}
