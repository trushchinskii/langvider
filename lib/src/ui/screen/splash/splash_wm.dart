import 'package:langvider/src/interactor/auth/auth_interactor.dart';
import 'package:langvider/src/interactor/learning/learning_interactor.dart';
import 'package:langvider/src/interactor/notification/notification_interactor.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/screen/login/login_screen_route.dart';
import 'package:langvider/src/ui/screen/main/main_screen_route.dart';
import 'package:pedantic/pedantic.dart';

class SplashScreenWm extends BaseWidgetModel {
  SplashScreenWm(
    WmDependencies dependencies,
    this._authInteractor,
    this._notificationInteractor,
    this._learningInteractor,
  ) : super(dependencies) {
    _checkUserLogin();
    _learningInteractor.scheduleNextLearningNotification();
  }

  final AuthInteractor _authInteractor;
  final NotificationInteractor _notificationInteractor;
  final LearningInteractor _learningInteractor;

  Future<void> _checkUserLogin() async {
    final Future<List<bool>> futures = Future.wait([
      _authInteractor.isUserLogin,
      Future.delayed(const Duration(seconds: 1)),
      _notificationInteractor.initialize(),
    ]);

    final isUserAuth = (await futures)[0];

    if (isUserAuth) {
      unawaited(navigator.pushReplacement(MainScreenRoute()));
    } else {
      unawaited(navigator.pushReplacement(LoginScreenRoute()));
    }
  }
}
