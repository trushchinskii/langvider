import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class ProviderUtils {
  static T provide<T>(
    BuildContext context, {
    bool listen = false,
  }) {
    return Provider.of<T>(context, listen: listen);
  }
}
