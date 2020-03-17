import 'package:langvider/src/domain/user.dart';
import 'package:langvider/src/interactors/auth/auth_interactor.dart';
import 'package:langvider/src/ui/base/navigator/global_navigator.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/screens/login/login_screen_route.dart';
import 'package:langvider/src/ui/screens/main/main_screen_route.dart';

class SplashScreenWm extends BaseWidgetModel {
  final GlobalNavigator _navigator;
  final AuthInteractor _authInteractor;

  SplashScreenWm(
    WmDependencies dependencies,
    this._navigator,
    this._authInteractor,
  ) : super(dependencies) {
    _checkUserAuth();
  }

  void _checkUserAuth() async {
    Future<List> futures = Future.wait([
      _authInteractor.isUserAuth,
      Future.delayed(Duration(seconds: 1)),
    ]);

    bool isUserAuth = (await futures)[0];

    if (isUserAuth) {
      _navigator.pushReplacement(MainScreenRoute());
    } else {
      _auth();
    }
  }

  void _auth() async {
    try {
      User user = await _authInteractor.signIn();

      if (user != null) {
        _navigator.pushReplacement(MainScreenRoute());
        return;
      }
    } catch (e) {
      logger.e(e);
    }

    _navigator.pushReplacement(LoginScreenRoute());
  }
}
