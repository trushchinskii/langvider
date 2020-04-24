import 'package:flutter/material.dart';
import 'package:langvider/src/interactor/dictionary/dictionary_interactor.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/screen/trainings/selecting/selecting_training_screen.dart';
import 'package:langvider/src/ui/screen/trainings/selecting/selecting_training_wm.dart';
import 'package:langvider/src/ui/screen/trainings/training_screen_type.dart';
import 'package:langvider/src/ui/utils/provider_utils.dart';
import 'package:provider/provider.dart';

class SelectingTrainingScreenRoute extends MaterialPageRoute<void> {
  SelectingTrainingScreenRoute(TrainingScreenType screenType)
      : super(
          builder: (context) => _SelectingTrainingScreenProvider(
            screenType: screenType,
            child: SelectingTrainingScreen(screenType: screenType),
          ),
        );
}

class _SelectingTrainingScreenProvider
    extends Provider<SelectingTrainingScreenWm> {
  _SelectingTrainingScreenProvider({
    @required TrainingScreenType screenType,
    @required Widget child,
  }) : super(
          create: (context) => SelectingTrainingScreenWm(
            WmDependencies(context, GlobalKey()),
            screenType,
            ProviderUtils.provide<DictionaryInteractor>(context),
          ),
          child: child,
        );
}
