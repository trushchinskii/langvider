import 'package:flutter/widgets.dart';
import 'package:langvider/src/interactors/auth/auth_interactor.dart';
import 'package:langvider/src/interactors/auth/repository/auth_repository.dart';
import 'package:langvider/src/interactors/common/http/http.dart';
import 'package:langvider/src/interactors/common/http/implementation/dio_http.dart';
import 'package:langvider/src/ui/base/navogator/global_navigator.dart';
import 'package:provider/provider.dart';

/// This provider creates dependencies for app's scope
class AppProvider extends MultiProvider {
  AppProvider({
    @required Widget child,
  }) : super(
          providers: [
            Provider<GlobalNavigator>(
              create: (_) => GlobalNavigator(),
            ),
            Provider<Http>(
              create: (_) => DioHttp(),
            ),
            Provider<AuthInteractor>(
              create: (_) => AuthInteractor(
                AuthRepository(),
              ),
            ),
          ],
          child: child,
        );
}
