import 'package:flutter/widgets.dart';

class GlobalNavigator {
  final globalKey = GlobalKey<NavigatorState>();

  Future<T> push<T extends Object>(Route<T> route) {
    return globalKey.currentState.push(route);
  }

  Future<T> pushReplacement<T extends Object, TO extends Object>(
    Route<T> newRoute, {
    TO result,
  }) {
    return globalKey.currentState.pushReplacement(newRoute, result: result);
  }
}
