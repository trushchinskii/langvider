import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/screen/base_widget.dart';
import 'package:langvider/src/ui/screen/dictionary/dictionary_wm.dart';

class DictionaryScreen extends BaseWidget {
  @override
  BaseWidgetState buildState() => _DictionaryState();
}

class _DictionaryState
    extends BaseWidgetState<DictionaryScreen, DictionaryScreenWm> {
  
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      key: wm.scaffoldKey,
      body: const Center(child: Text('Dictionary')),
    );
  }
}
