import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/screen/base_widget.dart';
import 'package:langvider/src/ui/screen/debug/debug_wm.dart';

class DebugScreen extends BaseWidget {
  @override
  BaseWidgetState buildState() => _DebugState();
}

class _DebugState extends BaseWidgetState<DebugScreen, DebugScreenWm> {
  @override
  Widget build(BuildContext context) => Scaffold(
        key: wm.scaffoldKey,
        body: const Center(child: Text('Debug Screen')),
      );
}
