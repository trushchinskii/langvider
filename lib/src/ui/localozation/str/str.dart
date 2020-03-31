import 'package:flutter/material.dart';

abstract class Str {
  static Str of(BuildContext context) {
    return Localizations.of<Str>(context, Str);
  }

  // Splash Screen
  String get splashScreenTitle => 'Langvider';

  // Login Screen
  String get loginTitle => 'Войти:';
  String get googleButtonText => 'GOOGLE';
  String get loginTooltip => 'Войдите в учётную запись';

  // Errors
  String get loginError => 'Произошла ошибка авторизации.\n'
      'Проверьте соединение с интернетом и повторите снова';
}
