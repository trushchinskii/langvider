import 'package:flutter/material.dart';

abstract class Str {
  static Str of(BuildContext context) {
    return Localizations.of<Str>(context, Str);
  }

  // Splash Screen
  String get splashScreenTitle => "Langvider";

  // Login Screen
  String get authTitle => "Войти:";
  String get googleButtonText => "GOOGLE";

  // Errors
  String get authError => "Authorization error";
}
