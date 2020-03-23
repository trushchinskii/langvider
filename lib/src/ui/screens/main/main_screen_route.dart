import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/screens/main/main_screen.dart';
import 'package:langvider/src/ui/screens/main/main_wm.dart';
import 'package:provider/provider.dart';

class MainScreenRoute extends MaterialPageRoute {
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
          ),
          child: child,
        );
}
