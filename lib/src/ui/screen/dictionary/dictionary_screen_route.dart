import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/screen/dictionary/dictionary_screen.dart';
import 'package:langvider/src/ui/screen/dictionary/dictionary_wm.dart';
import 'package:provider/provider.dart';

class DictionaryScreenRoute extends MaterialPageRoute<void> {
  DictionaryScreenRoute()
      : super(
          builder: (context) => _DictionaryScreenProvider(
            child: DictionaryScreen(),
          ),
        );
}

class _DictionaryScreenProvider extends Provider<DictionaryScreenWm> {
  _DictionaryScreenProvider({
    @required Widget child,
  }) : super(
          create: (context) => DictionaryScreenWm(
            WmDependencies(context, GlobalKey()),
          ),
          child: child,
        );
}
