import 'package:flutter/foundation.dart';

class Word {
  Word({
    @required this.text,
    @required this.translation,
  }) : assert(text != null && translation != null);

  final String text;
  final String translation;
}
