import 'package:flutter/widgets.dart';
import 'package:langvider/src/interactor/auth/auth_interactor.dart';
import 'package:langvider/src/interactor/auth/repository/auth_repository.dart';
import 'package:langvider/src/interactor/common/http/http.dart';
import 'package:langvider/src/interactor/common/http/implementation/dio_http.dart';
import 'package:langvider/src/interactor/dictionary/dictionary_interactor.dart';
import 'package:langvider/src/interactor/dictionary/repository/dictionary_repository.dart';
import 'package:langvider/src/ui/base/navigator/global_navigator.dart';
import 'package:langvider/src/ui/utils/provider_utils.dart';
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
              create: (_) => AuthInteractor(AuthRepository()),
            ),
            Provider<DictionaryInteractor>(
              create: (context) => DictionaryInteractor(
                DictionaryRepository(),
                ProviderUtils.provide<AuthInteractor>(context),
              ),
            ),
          ],
          child: child,
        );
}
