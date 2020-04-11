import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/screen/base_widget.dart';
import 'package:langvider/src/ui/screen/login/login_wm.dart';
import 'package:langvider/src/ui/screen/splash/widget/splash_widget.dart';
import 'package:langvider/src/ui/widget/rounded_button.dart';

class LoginScreen extends BaseWidget {
  @override
  BaseWidgetState buildState() => _LoginState();
}

class _LoginState extends BaseWidgetState<LoginScreen, LoginScreenWm> {
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      key: wm.scaffoldKey,
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
            str.loginTitle,
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(height: 24),
          RoundedButton(
            title: str.googleButtonText,
            onPressed: wm.loginAction,
          ),
          SizedBox(height: 64)
        ],
      ),
    );
  }
}
