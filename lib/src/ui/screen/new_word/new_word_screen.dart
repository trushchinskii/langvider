import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/screen/base_widget.dart';
import 'package:langvider/src/ui/screen/new_word/new_word_wm.dart';

class NewWordScreen extends BaseWidget {
  @override
  BaseWidgetState buildState() => _NewWordState();
}

class _NewWordState extends BaseWidgetState<NewWordScreen, NewWordScreenWm> {
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      key: wm.scaffoldKey,
      body: Center(
        // TODO
        child: Text('New Word'),
      ),
    );
  }
}
