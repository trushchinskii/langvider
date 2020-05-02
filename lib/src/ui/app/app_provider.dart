import 'package:flutter/widgets.dart';
import 'package:langvider/src/interactor/auth/auth_interactor.dart';
import 'package:langvider/src/interactor/auth/repository/auth_repository.dart';
import 'package:langvider/src/interactor/common/http/http.dart';
import 'package:langvider/src/interactor/common/http/implementation/dio_http.dart';
import 'package:langvider/src/interactor/dictionary/dictionary_interactor.dart';
import 'package:langvider/src/interactor/dictionary/repository/dictionary_repository.dart';
import 'package:langvider/src/interactor/learning/learning_interactor.dart';
import 'package:langvider/src/interactor/notification/notification_interactor.dart';
import 'package:langvider/src/interactor/training/training_interactor.dart';
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
            Provider<NotificationInteractor>(
              create: (_) => NotificationInteractor(),
            ),
            Provider<LearningInteractor>(
              create: (context) => LearningInteractor(
                ProviderUtils.provide<DictionaryInteractor>(context),
                ProviderUtils.provide<NotificationInteractor>(context),
              ),
            ),
            Provider<TrainingInteractor>(
              create: (context) => TrainingInteractor(
                ProviderUtils.provide<DictionaryInteractor>(context),
              ),
            ),
          ],
          child: child,
        );
}
