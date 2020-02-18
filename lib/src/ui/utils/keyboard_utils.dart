import 'package:flutter/material.dart';

abstract class KeyboardUtils {
  static bool isVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom != 0;
  }

  static bool isHidden(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom == 0;
  }
}
