import 'package:flutter/material.dart';
import 'package:langvider/src/interactor/auth/auth_interactor.dart';
import 'package:langvider/src/interactor/notification/notification_interactor.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/screen/splash/splash_wm.dart';
import 'package:langvider/src/ui/utils/provider_utils.dart';
import 'package:provider/provider.dart';

import 'splash_screen.dart';

class SplashScreenRoute extends MaterialPageRoute<void> {
  SplashScreenRoute()
      : super(
          builder: (context) {
            return _SplashScreenProvider(
              child: SplashScreen(),
            );
          },
        );

  static const name = '/';
}

class _SplashScreenProvider extends Provider<SplashScreenWm> {
  _SplashScreenProvider({
    @required Widget child,
  }) : super(
          create: (context) {
            return SplashScreenWm(
              WmDependencies(context, GlobalKey()),
              ProviderUtils.provide<AuthInteractor>(context),
              ProviderUtils.provide<NotificationInteractor>(context),
            );
          },
          child: child,
        );
}
