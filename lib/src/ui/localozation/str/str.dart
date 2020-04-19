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

  // MainScreen
  String get mainScreenDictionaryTitle => 'Словарь';

  // New Word
  String get newWordAppBarTitle => 'Новое слово';
  String get newWordWordLabel => 'Слово';
  String get newWordTranslationLabel => 'Перевод';
  String get newWordButtonText => 'Добавить';

  // Dictionary
  String get dictionaryAppBarTitle => 'Словарь';
  String get dictionaryErrorText => 'Произошла ошибка';
  String get dictionaryRepeatText => 'Повторить';
  String get dictionaryEmptyText => 'Словарь пуст\nДобавьте новые слова';

  // Errors
  String get loginError => 'Произошла ошибка авторизации.\n'
      'Проверьте соединение с интернетом и повторите снова';
}
