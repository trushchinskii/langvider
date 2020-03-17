import 'dart:async';

import 'package:langvider/src/interactors/auth/auth_interactor.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';

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

  void _login() {
    try {
      _authInteractor.signIn();
    } catch (e) {
      // TODO handle error
      // TODO rename auth to login by app
    }
  }
}
