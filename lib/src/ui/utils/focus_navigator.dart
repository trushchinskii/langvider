import 'package:flutter/widgets.dart';

class FocusNavigator {
  FocusNavigator(this._focusNodes);

  final List<FocusNode> _focusNodes;

  void next() {
    for (int i = 0; i < _focusNodes.length; i++) {
      if (_focusNodes[i].hasFocus && _focusNodes.length > i + 1) {
        _focusNodes[i + 1].requestFocus();
      }
    }
  }
}
