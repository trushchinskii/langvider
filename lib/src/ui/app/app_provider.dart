import 'package:flutter/widgets.dart';
import 'package:langvider/src/interactors/common/http/http.dart';
import 'package:langvider/src/interactors/common/http/implementation/dio_http.dart';
import 'package:provider/provider.dart';

/// This provider creates dependencies for app's scope
class AppProvider extends MultiProvider {
  AppProvider({
    @required Widget child,
  }) : super(
          providers: [
            Provider<Http>(
              create: (_) => DioHttp(),
            ),
          ],
          child: child,
        );
}
