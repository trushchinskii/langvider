import 'package:flutter/material.dart';
import 'package:langvider/src/interactor/learning/learning_interactor.dart';
import 'package:langvider/src/interactor/training/training_interactor.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/screen/learning/learning_screen.dart';
import 'package:langvider/src/ui/screen/learning/learning_wm.dart';
import 'package:langvider/src/ui/utils/provider_utils.dart';
import 'package:provider/provider.dart';

class LearningScreenRoute extends MaterialPageRoute<void> {
  LearningScreenRoute()
      : super(
          builder: (context) => _LearningScreenProvider(
            child: LearningScreen(),
          ),
        );
}

class _LearningScreenProvider extends Provider<LearningScreenWm> {
  _LearningScreenProvider({
    @required Widget child,
  }) : super(
          create: (context) => LearningScreenWm(
            WmDependencies(context, GlobalKey()),
            ProviderUtils.provide<LearningInteractor>(context),
            ProviderUtils.provide<TrainingInteractor>(context),
          ),
          child: child,
        );
}
