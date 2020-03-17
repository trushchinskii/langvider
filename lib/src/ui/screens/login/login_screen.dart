import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/screen/base_widget.dart';
import 'package:langvider/src/ui/screens/login/login_wm.dart';

class LoginScreen extends BaseWidget {
  @override
  BaseWidgetState buildState() => _LoginState();
}

class _LoginState extends BaseWidgetState<LoginScreen, LoginScreenWm> {
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: Center(
        // TODO implement login body
        child: Text("Login"),
      ),
    );
  }
}
