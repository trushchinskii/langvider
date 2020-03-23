import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:langvider/src/ui/base/message_controller/message_controller.dart';
import 'package:langvider/src/ui/base/navigator/global_navigator.dart';
import 'package:langvider/src/ui/localozation/str/str.dart';
import 'package:langvider/src/ui/utils/provider_utils.dart';

class BaseWidgetModel {
  final MessageController messageController;
  final GlobalNavigator globalNavigator;
  final Str str;

  final GlobalKey<ScaffoldState> scaffoldKey;

  BaseWidgetModel(WmDependencies dependencies)
      : scaffoldKey = dependencies.scaffoldKey,
        messageController = dependencies.messageController,
        globalNavigator = dependencies.globalNavigator,
        str = dependencies.str;

  /// Executes when widget attached to tree
  void onAttached() {}

  /// Executed when widget call dispose method
  void dispose() {}
}

class WmDependencies {
  final MessageController messageController;
  final GlobalNavigator globalNavigator;
  final Str str;

  final GlobalKey<ScaffoldState> scaffoldKey;

  WmDependencies(
    BuildContext context,
    this.scaffoldKey,
  )   : messageController = MessageController(scaffoldKey),
        globalNavigator = ProviderUtils.provide<GlobalNavigator>(context),
        str = Str.of(
          ProviderUtils.provide<GlobalNavigator>(context)
              .globalKey
              .currentContext,
        );
}
