import 'package:flutter/material.dart';
import 'package:langvider/src/interactors/auth/auth_interactor.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/screens/login/login_screen.dart';
import 'package:langvider/src/ui/screens/login/login_wm.dart';
import 'package:langvider/src/ui/utils/provider_utils.dart';
import 'package:provider/provider.dart';

class LoginScreenRoute extends MaterialPageRoute {
  LoginScreenRoute()
      : super(
          builder: (context) => _LoginScreenProvider(
            child: LoginScreen(),
          ),
        );
}

class _LoginScreenProvider extends Provider<LoginScreenWm> {
  _LoginScreenProvider({
    @required Widget child,
  }) : super(
          create: (context) => LoginScreenWm(
            WmDependencies(context, GlobalKey()),
            ProviderUtils.provide<AuthInteractor>(context),
          ),
          child: child,
        );
}
