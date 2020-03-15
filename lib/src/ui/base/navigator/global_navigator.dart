import 'package:flutter/widgets.dart';

class GlobalNavigator {
  final globalKey = GlobalKey<NavigatorState>();

  Future<T> pushReplacement<T extends Object, TO extends Object>(
    Route<T> newRoute, {
    TO result,
  }) {
    return globalKey.currentState.pushReplacement(newRoute, result: result);
  }
}
