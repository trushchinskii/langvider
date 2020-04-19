import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:langvider/src/ui/base/message_controller/message_controller.dart';
import 'package:langvider/src/ui/base/navigator/global_navigator.dart';
import 'package:langvider/src/ui/base/state_management/state/base/streamable.dart';
import 'package:langvider/src/ui/localozation/str/str.dart';
import 'package:langvider/src/ui/utils/provider_utils.dart';

class BaseWidgetModel {
  BaseWidgetModel(WmDependencies dependencies)
      : scaffoldKey = dependencies.scaffoldKey,
        messageController = dependencies.messageController,
        navigator = dependencies.globalNavigator,
        str = dependencies.str {
    initListeners();
  }

  final MessageController messageController;
  final GlobalNavigator navigator;
  final Str str;

  final GlobalKey<ScaffoldState> scaffoldKey;

  final _streams = <Streamable>[];

  /// Executes when widget attached to tree
  void onAttached() {}

  void initListeners() {
    // Init listeners for stream
  }

  void listen<T>(Streamable<T> stream, void Function(T data) listener) {
    _streams.add(stream);
    stream.stream.listen(listener);
  }

  /// Executed when widget call dispose method
  void dispose() {
    for (Streamable stream in _streams) {
      stream.close();
    }
  }

  void handleError(Exception e) {
    messageController.showSnack(e.toString());
  }
}

class WmDependencies {
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

  final MessageController messageController;
  final GlobalNavigator globalNavigator;
  final Str str;

  final GlobalKey<ScaffoldState> scaffoldKey;
}
