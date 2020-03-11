import 'package:flutter/material.dart';
import 'package:langvider/src/ui/screens/splash/splash_wm.dart';
import 'package:provider/provider.dart';

import 'splash_screen.dart';

class SplashScreenRoute extends MaterialPageRoute {
  static const name = "/";

  SplashScreenRoute()
      : super(
          builder: (context) => _SplashScreenProvider(
            child: SplashScreen(),
          ),
        );
}

class _SplashScreenProvider extends Provider<SplashScreenWm> {
  _SplashScreenProvider({
    @required Widget child,
  }) : super(
          create: (_) => SplashScreenWm(),
          child: child,
        );
}
