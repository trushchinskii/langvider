import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/screen/base_widget.dart';
import 'package:langvider/src/ui/screen/template/template_wm.dart';

class TemplateScreen extends BaseWidget {
  @override
  BaseWidgetState buildState() => _TemplateState();
}

class _TemplateState extends BaseWidgetState<TemplateScreen, TemplateScreenWm> {
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      key: wm.scaffoldKey,
      body: Center(
        child: Text('TODO'),
      ),
    );
  }
}
