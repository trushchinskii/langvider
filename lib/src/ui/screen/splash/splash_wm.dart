import 'package:langvider/src/interactor/auth/auth_interactor.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/screen/login/login_screen_route.dart';
import 'package:langvider/src/ui/screen/main/main_screen_route.dart';
import 'package:pedantic/pedantic.dart';

class SplashScreenWm extends BaseWidgetModel {
  SplashScreenWm(
    WmDependencies dependencies,
    this._authInteractor,
  ) : super(dependencies) {
    _checkUserLogin();
  }

  final AuthInteractor _authInteractor;

  Future<void> _checkUserLogin() async {
    final Future<List<bool>> futures = Future.wait([
      _authInteractor.isUserLogin,
      Future.delayed(Duration(seconds: 1)),
    ]);

    final isUserAuth = (await futures)[0];

    if (isUserAuth) {
      unawaited(navigator.pushReplacement(MainScreenRoute()));
    } else {
      unawaited(navigator.pushReplacement(LoginScreenRoute()));
    }
  }
}
