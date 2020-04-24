import 'package:flutter/material.dart';
import 'package:langvider/src/interactor/dictionary/dictionary_interactor.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/screen/trainings/trainings_screen.dart';
import 'package:langvider/src/ui/screen/trainings/trainings_wm.dart';
import 'package:langvider/src/ui/utils/provider_utils.dart';
import 'package:provider/provider.dart';

class TrainingsScreenRoute extends MaterialPageRoute<void> {
  TrainingsScreenRoute()
      : super(
          builder: (context) => _TrainingsScreenProvider(
            child: TrainingsScreen(),
          ),
        );
}

class _TrainingsScreenProvider extends Provider<TrainingsScreenWm> {
  _TrainingsScreenProvider({
    @required Widget child,
  }) : super(
          create: (context) => TrainingsScreenWm(
            WmDependencies(context, GlobalKey()),
            ProviderUtils.provide<DictionaryInteractor>(context),
          ),
          child: child,
        );
}
