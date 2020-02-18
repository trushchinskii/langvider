import 'package:flutter/material.dart';
import 'package:langvider/src/ui/screens/splash/splash_screen.dart';
import 'package:langvider/src/ui/screens/splash/splash_widget_model.dart';
import 'package:provider/provider.dart';

class SplashScreenRoute extends MaterialPageRoute {
  static const name = "/";

  SplashScreenRoute()
      : super(
          builder: (context) => SplashScreenProvider(
            child: SplashScreen(),
          ),
        );
}

class SplashScreenProvider extends Provider<SplashScreenWidgetModel> {
  SplashScreenProvider({
    @required Widget child,
  }) : super(
          create: (_) => SplashScreenWidgetModel(),
          child: child,
        );
}
