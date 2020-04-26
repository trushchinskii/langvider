import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/screen/base_widget.dart';
import 'package:langvider/src/ui/screen/debug/debug_wm.dart';
import 'package:langvider/src/ui/utils/text_styles.dart';

class DebugScreen extends BaseWidget {
  @override
  BaseWidgetState buildState() => _DebugState();
}

class _DebugState extends BaseWidgetState<DebugScreen, DebugScreenWm> {
  @override
  Widget build(BuildContext context) => Scaffold(
        key: wm.scaffoldKey,
        body: _buildBody(),
      );

  Widget _buildBody() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      children: [
        _buildNotificationWidgets(),
      ],
    );
  }

  Widget _buildNotificationWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Notifications:',
          style: h5,
        ),
        RaisedButton(
          child: const Text('Display notification'),
          onPressed: wm.displayNotificationAction,
        ),
        RaisedButton(
          child: const Text('Display notification after 5 seconds'),
          onPressed: wm.displayNotificationAfter5SecondsAction,
        ),
      ],
    );
  }
}
