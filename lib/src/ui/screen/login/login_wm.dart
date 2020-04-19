import 'dart:async';

import 'package:langvider/src/interactor/auth/auth_interactor.dart';
import 'package:langvider/src/interactor/common/exception/login_exception.dart';
import 'package:langvider/src/ui/base/message_controller/message_controller.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/base/state_management/state/action.dart';
import 'package:langvider/src/ui/screen/main/main_screen_route.dart';
import 'package:pedantic/pedantic.dart';

class LoginScreenWm extends BaseWidgetModel {
  LoginScreenWm(
    WmDependencies dependencies,
    this._authInteractor,
  ) : super(dependencies);

  final AuthInteractor _authInteractor;

  final loginAction = Action();

  @override
  void initListeners() {
    listen(loginAction, (_) => _login());
  }

  Future<void> _login() async {
    try {
      final isUserLogin = await _authInteractor.login();
      if (isUserLogin) {
        unawaited(navigator.pushReplacement(MainScreenRoute()));
      } else {
        messageController.showSnack(
          str.loginTooltip,
          type: MessageType.info,
        );
      }
    } on LoginException {
      messageController.showSnack(
        str.loginError,
        type: MessageType.error,
      );
    } on Exception catch (e) {
      handleError(e);
    }
  }
}
