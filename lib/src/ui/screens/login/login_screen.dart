import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/screen/base_widget.dart';
import 'package:langvider/src/ui/screens/login/login_wm.dart';
import 'package:langvider/src/ui/screens/splash/widget/splash_widget.dart';
import 'package:langvider/src/ui/widget/rounded_button.dart';

class LoginScreen extends BaseWidget {
  @override
  BaseWidgetState buildState() => _LoginState();
}

class _LoginState extends BaseWidgetState<LoginScreen, LoginScreenWm> {
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 144,
            width: double.infinity,
          ),
          SplashWidget(
            str.splashScreenTitle,
          ),
          Expanded(
            child: SizedBox(),
          ),
          Text(
            str.authTitle,
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(height: 24),
          RoundedButton(
            title: str.googleButtonText,
            onPressed: () {
              wm.loginSink.add(null);
            },
          ),
          SizedBox(height: 64)
        ],
      ),
    );
  }
}
