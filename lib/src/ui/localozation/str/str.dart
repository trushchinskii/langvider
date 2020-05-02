import 'package:flutter/material.dart';

abstract class Str {
  static Str of(BuildContext context) {
    return Localizations.of<Str>(context, Str);
  }

  // Common
  String get repeat => 'Повторить';

  // Splash Screen
  String get splashScreenTitle => 'Langvider';

  // Login Screen
  String get loginTitle => 'Войти:';
  String get googleButtonText => 'GOOGLE';
  String get loginTooltip => 'Войдите в учётную запись';

  // MainScreen
  String get mainScreenLearningWordsTitle => 'Повторите слова';
  String get mainScreenDictionaryTitle => 'Словарь';
  String get mainScreenTrainingsTitle => 'Тренировки';
  String get mainScreenHasNotLearningWordsText =>
      'Нет доступных слов для изучения';

  // New Word
  String get newWordAppBarTitle => 'Новое слово';
  String get newWordWordLabel => 'Слово';
  String get newWordTranslationLabel => 'Перевод';
  String get newWordButtonText => 'Добавить';

  // Dictionary
  String get dictionaryAppBarTitle => 'Словарь';
  String get dictionaryErrorText => 'Произошла ошибка';
  String get dictionaryEmptyText => 'Словарь пуст\nДобавьте новые слова';

  // Trainings
  String get trainingsEmptyStateText =>
      'Недостаточное количество слов\nдля тренировок';
  String get trainingsErrorText =>
      'Произошла ошибка.\nПроверьте соединение с сетью';

  String get trainingsSelectTextTranslationText => 'Выбрать перевод к слову';
  String get trainingsSelectTranslationTextText => 'Выбрать слово к переводу';
  String get trainingsSelectCompleteText => 'Готово';
  String get trainingsWriteTextTranslationText => 'Написать перевод к слову';
  String get trainingsWriteTranslationTextText => 'Написать слово к переводу';

  // Errors
  String get loginError => 'Произошла ошибка авторизации.\n'
      'Проверьте соединение с интернетом и повторите снова';
}
