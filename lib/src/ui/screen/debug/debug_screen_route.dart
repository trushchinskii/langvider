import 'package:flutter/material.dart';
import 'package:langvider/src/interactor/notification/notification_interactor.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/screen/debug/debug_screen.dart';
import 'package:langvider/src/ui/screen/debug/debug_wm.dart';
import 'package:langvider/src/ui/utils/provider_utils.dart';
import 'package:provider/provider.dart';

class DebugScreenRoute extends MaterialPageRoute<void> {
  DebugScreenRoute()
      : super(
          builder: (context) => _DebugScreenProvider(
            child: DebugScreen(),
          ),
        );
}

class _DebugScreenProvider extends Provider<DebugScreenWm> {
  _DebugScreenProvider({
    @required Widget child,
  }) : super(
          create: (context) => DebugScreenWm(
            WmDependencies(context, GlobalKey()),
            ProviderUtils.provide<NotificationInteractor>(context),
          ),
          child: child,
        );
}
