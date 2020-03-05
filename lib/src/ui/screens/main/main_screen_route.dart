import 'package:flutter/material.dart';
import 'package:langvider/src/ui/screens/main/main_screen.dart';
import 'package:langvider/src/ui/screens/main/main_wm.dart';
import 'package:provider/provider.dart';

class MainScreenRoute extends MaterialPageRoute {
  static const name = "/";

  MainScreenRoute()
      : super(
          builder: (context) => _SplashScreenProvider(
            child: MainScreen(),
          ),
        );
}

class _SplashScreenProvider extends Provider<MainScreenWm> {
  _SplashScreenProvider({
    @required Widget child,
  }) : super(
          create: (_) => MainScreenWm(),
          child: child,
        );
}
