import 'package:flutter/widgets.dart';
import 'package:langvider/src/ui/utils/provider_utils.dart';
import 'package:logger/logger.dart';

/// Base widget-model class
class BaseWidgetModel {
  final Logger logger;

  BaseWidgetModel(WmDependencies dependencies) : logger = dependencies.logger;

  /// Executes when widget attached to tree
  void onAttached() {}

  /// Executed when widget call dispose method
  void dispose() {}
}

class WmDependencies {
  final Logger logger;

  WmDependencies(BuildContext context)
      : logger = ProviderUtils.provide<Logger>(context);
}
