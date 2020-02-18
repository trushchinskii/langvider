import 'package:flutter/material.dart';

abstract class LocalizationConfig {
  static const ruLocale = Locale("ru");
  static const enLocale = Locale("en");

  static const supportedLocales = <Locale>[ruLocale, enLocale];
}
