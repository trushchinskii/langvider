import 'package:flutter/material.dart';
import 'package:langvider/src/interactor/learning/learning_interactor.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/screen/main/main_screen.dart';
import 'package:langvider/src/ui/screen/main/main_wm.dart';
import 'package:langvider/src/ui/utils/provider_utils.dart';
import 'package:provider/provider.dart';

class MainScreenRoute extends MaterialPageRoute<void> {
  MainScreenRoute()
      : super(
          builder: (context) => _MainScreenProvider(
            child: MainScreen(),
          ),
        );
}

class _MainScreenProvider extends Provider<MainScreenWm> {
  _MainScreenProvider({
    @required Widget child,
  }) : super(
          create: (context) => MainScreenWm(
            WmDependencies(context, GlobalKey()),
            ProviderUtils.provide<LearningInteractor>(context),
          ),
          child: child,
        );
}
