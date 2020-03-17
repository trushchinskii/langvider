import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:langvider/src/ui/base/navigator/global_navigator.dart';
import 'package:langvider/src/ui/localozation/localization_config.dart';
import 'package:langvider/src/ui/localozation/localization_delegate.dart';
import 'package:langvider/src/ui/utils/colors.dart';
import 'package:langvider/src/ui/screens/splash/splash_screen_route.dart';
import 'package:langvider/src/ui/utils/provider_utils.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: ProviderUtils.provide<GlobalNavigator>(context).globalKey,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        AppLocalizationsDelegate()
      ],
      supportedLocales: LocalizationConfig.supportedLocales,
      theme: _buildAppTheme(),
      initialRoute: SplashScreenRoute.name,
      onGenerateRoute: (RouteSettings settings) {
        return _onGenerateFirstRoute(settings);
      },
    );
  }

  ThemeData _buildAppTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
        primaryColor: primaryColor,
        primaryColorLight: primaryLightColor,
        primaryColorDark: primaryDarkColor,
        accentColor: secondaryColor,
        errorColor: errorColor,
        buttonTheme: base.buttonTheme.copyWith(
          buttonColor: secondaryColor,
          shape: RoundedRectangleBorder(),
          textTheme: ButtonTextTheme.primary,
        ),
        bottomAppBarColor: primaryColor,
        floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
          backgroundColor: secondaryColor,
        ),
        scaffoldBackgroundColor: backgroundColor,
        accentIconTheme: base.iconTheme.copyWith(color: secondaryIconColor),
        primaryIconTheme: base.iconTheme.copyWith(color: primaryIconColor),
        textTheme: _buildTextTheme(base.textTheme),
        primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
        accentTextTheme: _buildTextTheme(base.accentTextTheme),
        iconTheme: base.iconTheme.copyWith(color: primaryIconColor),
        appBarTheme: base.appBarTheme.copyWith(color: primaryColor));
  }

  // https://api.flutter.dev/flutter/material/TextTheme-class.html
  TextTheme _buildTextTheme(TextTheme base) {
    return base
        .copyWith(
            title: TextStyle(
          color: onPrimaryColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        )
//        headline: base.headline.copyWith(\
//          fontWeight: FontWeight.w500,
//        ),
//        title: base.title.copyWith(fontSize: 18.0),
//        caption: base.caption.copyWith(
//          fontWeight: FontWeight.w400,
//          fontSize: 14.0,
//        ),
//        body2: base.body2.copyWith(
//          fontWeight: FontWeight.w500,
//          fontSize: 16.0,
//        ),
            )
        .apply(
//        fontFamily: 'Rubik',
//        displayColor: kShrineBrown900,
//        bodyColor: kShrineBrown900,
            );
  }

  Route _onGenerateFirstRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreenRoute.name:
        return SplashScreenRoute();
      default:
        throw Exception("Unknown route name ${settings.name}");
    }
  }
}
