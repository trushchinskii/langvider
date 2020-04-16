import 'package:flutter/material.dart';
import 'package:langvider/src/interactor/dictionary/dictionary_interactor.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/screen/new_word/new_word_screen.dart';
import 'package:langvider/src/ui/screen/new_word/new_word_wm.dart';
import 'package:langvider/src/ui/utils/provider_utils.dart';
import 'package:provider/provider.dart';

class NewWordScreenRoute extends MaterialPageRoute<void> {
  NewWordScreenRoute()
      : super(
          builder: (context) => _NewWordScreenProvider(
            child: NewWordScreen(),
          ),
        );
}

class _NewWordScreenProvider extends Provider<NewWordScreenWm> {
  _NewWordScreenProvider({
    @required Widget child,
  }) : super(
          create: (context) => NewWordScreenWm(
            WmDependencies(context, GlobalKey()),
            ProviderUtils.provide<DictionaryInteractor>(context),
          ),
          child: child,
        );
}
