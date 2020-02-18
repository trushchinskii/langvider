import 'package:flutter/material.dart';

abstract class Str {
  static Str of(BuildContext context) {
    return Localizations.of<Str>(context, Str);
  }

  // Splash Screen
  String get splashScreenTitle => "Главный экран";
}
