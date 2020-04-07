import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/screen/template/template_screen.dart';
import 'package:langvider/src/ui/screen/template/template_wm.dart';
import 'package:provider/provider.dart';

class TemplateScreenRoute extends MaterialPageRoute<void> {
  TemplateScreenRoute()
      : super(
          builder: (context) => _TemplateScreenProvider(
            child: TemplateScreen(),
          ),
        );
}

class _TemplateScreenProvider extends Provider<TemplateScreenWm> {
  _TemplateScreenProvider({
    @required Widget child,
  }) : super(
          create: (context) => TemplateScreenWm(
            WmDependencies(context, GlobalKey()),
          ),
          child: child,
        );
}
