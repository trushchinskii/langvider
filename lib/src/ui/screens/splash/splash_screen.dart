import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/base_widget.dart';
import 'package:langvider/src/ui/screens/splash/splash_widget_model.dart';

class SplashScreen extends BaseWidget {
  @override
  BaseWidgetState buildState() => _SplashState();
}

class _SplashState
    extends BaseWidgetState<SplashScreen, SplashScreenWidgetModel> {
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(str.splashScreenTitle),
      ),
    );
  }
}
