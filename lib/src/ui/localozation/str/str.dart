import 'package:flutter/material.dart';

abstract class Str {
  static Str of(BuildContext context) {
    return Localizations.of<Str>(context, Str);
  }

  // Splash Screen
  String get splashScreenTitle => "Langvider";

  // Login Screen
  String get loginTitle => "Войти:";
  String get googleButtonText => "GOOGLE";

  // Errors
  String get loginError =>
      "Произошла ошибка авторизации. Проверьте соединение с интернетом и повторите снова";
}
