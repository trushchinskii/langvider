import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langvider/src/ui/localozation/localization_config.dart';
import 'package:langvider/src/ui/localozation/str/en_str.dart';
import 'package:langvider/src/ui/localozation/str/ru_str.dart';
import 'package:langvider/src/ui/localozation/str/str.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Str> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return LocalizationConfig.supportedLocales.contains(locale);
  }

  @override
  Future<Str> load(Locale locale) {
    Str str;

    if (locale == LocalizationConfig.ruLocale) {
      str = RuStr();
    } else {
      str = EnStr();
    }

    return SynchronousFuture<Str>(str);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
