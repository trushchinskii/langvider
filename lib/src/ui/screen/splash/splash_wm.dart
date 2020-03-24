import 'package:langvider/src/interactor/auth/auth_interactor.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/screen/login/login_screen_route.dart';
import 'package:langvider/src/ui/screen/main/main_screen_route.dart';

class SplashScreenWm extends BaseWidgetModel {
  final AuthInteractor _authInteractor;

  SplashScreenWm(
    WmDependencies dependencies,
    this._authInteractor,
  ) : super(dependencies) {
    _checkUserLogin();
  }

  void _checkUserLogin() async {
    Future<List> futures = Future.wait([
      _authInteractor.isUserLogin,
      Future.delayed(Duration(seconds: 1)),
    ]);

    bool isUserAuth = (await futures)[0];

    if (isUserAuth) {
      globalNavigator.pushReplacement(MainScreenRoute());
    } else {
      globalNavigator.pushReplacement(LoginScreenRoute());
    }
  }
}