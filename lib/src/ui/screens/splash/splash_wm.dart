import 'package:langvider/src/domain/user.dart';
import 'package:langvider/src/interactors/auth/auth_interactor.dart';
import 'package:langvider/src/ui/base/navogator/global_navigator.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/screens/login/login_screen_route.dart';
import 'package:langvider/src/ui/screens/main/main_screen_route.dart';

class SplashScreenWm extends BaseWidgetModel {
  final GlobalNavigator _navigator;
  final AuthInteractor _authInteractor;

  SplashScreenWm(
    this._navigator,
    this._authInteractor,
  ) {
    _checkUserAuth();
  }

  void _checkUserAuth() async {
    // TODO add Future.wait 1 second duration
    bool isUserAuth = await _authInteractor.isUserAuth;

    if (isUserAuth) {
      _navigator.pushReplacement(MainScreenRoute());
    } else {
      _auth();
    }
  }

  void _auth() async {
    try {
      User user = await _authInteractor.signIn();
      // TODO add error handligh
    } catch (e) {}

    _navigator.pushReplacement(LoginScreenRoute());
  }
}
