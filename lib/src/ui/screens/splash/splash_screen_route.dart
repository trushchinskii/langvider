import 'package:flutter/material.dart';
import 'package:langvider/src/interactors/auth/auth_interactor.dart';
import 'package:langvider/src/ui/base/navigator/global_navigator.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/screens/splash/splash_wm.dart';
import 'package:langvider/src/ui/utils/provider_utils.dart';
import 'package:provider/provider.dart';

import 'splash_screen.dart';

class SplashScreenRoute extends MaterialPageRoute {
  static const name = "/";

  SplashScreenRoute()
      : super(
          builder: (context) {
            return _SplashScreenProvider(
              child: SplashScreen(),
            );
          },
        );
}

class _SplashScreenProvider extends Provider<SplashScreenWm> {
  _SplashScreenProvider({
    @required Widget child,
  }) : super(
          create: (context) {
            return SplashScreenWm(
              WmDependencies(context),
              ProviderUtils.provide<GlobalNavigator>(context),
              ProviderUtils.provide<AuthInteractor>(context),
            );
          },
          child: child,
        );
}
