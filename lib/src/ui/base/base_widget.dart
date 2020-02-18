import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/base_widget_model.dart';
import 'package:langvider/src/ui/localozation/str/str.dart';
import 'package:provider/provider.dart';

/// Base class for functional widget
///
/// W - Widget type
/// B - Bloc type
abstract class BaseWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => buildState();

  BaseWidgetState buildState();
}

/// Base class for BaseWidget's state
///
/// W - Widget type
/// B - Widget-model type
abstract class BaseWidgetState<W extends BaseWidget, WM extends BaseWidgetModel>
    extends State<W> {
  WM wm;
  Str str;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => onAttached());
  }

  /// Executes after attached to tree
  void onAttached() {
    wm.onAttached();
  }

  @override
  Widget build(BuildContext context) {
    wm = Provider.of<WM>(
      context,
      listen: false,
    );
    str = Str.of(context);
    return buildWidget(context);
  }

  Widget buildWidget(BuildContext context);

  @override
  void dispose() {
    wm.dispose();
    super.dispose();
  }
}
