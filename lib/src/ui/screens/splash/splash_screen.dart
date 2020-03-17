import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/screen/base_widget.dart';
import 'package:langvider/src/ui/screens/splash/splash_wm.dart';
import 'package:langvider/src/ui/screens/splash/widget/splash_widget.dart';

class SplashScreen extends BaseWidget {
  @override
  BaseWidgetState buildState() => _SplashState();
}

class _SplashState extends BaseWidgetState<SplashScreen, SplashScreenWm> {
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SplashWidget(
          str.splashScreenTitle,
        ),
      ),
    );
  }
}
