import 'dart:async';

import 'package:langvider/src/domain/user.dart';
import 'package:langvider/src/interactors/auth/auth_interactor.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/screens/main/main_screen_route.dart';

class LoginScreenWm extends BaseWidgetModel {
  final AuthInteractor _authInteractor;

  final _streamController = StreamController<void>();
  Stream get loginStream => _streamController.stream;
  StreamSink get loginSink => _streamController.sink;

  LoginScreenWm(
    WmDependencies dependencies,
    this._authInteractor,
  ) : super(dependencies) {
    _initListeners();
  }

  @override
  void dispose() {
    _streamController.close();

    super.dispose();
  }

  void _initListeners() {
    _streamController.stream.listen((_) => _login());
  }

  void _login() async {
    try {
      User user = await _authInteractor.login();
      if (user != null) {
        globalNavigator.pushReplacement(MainScreenRoute());
      }
    } catch (e) {
      messageController.showSnack(str.loginError);
      // TODO handle error
    }
  }
}
