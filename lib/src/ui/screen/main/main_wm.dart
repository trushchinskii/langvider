import 'dart:async';

import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/screen/new_word/new_word_screen_route.dart';

class MainScreenWm extends BaseWidgetModel {
  MainScreenWm(WmDependencies dependencies) : super(dependencies) {
    _initListeners();
  }

  final openNewWordScreenSC = StreamController<void>();
  Sink get openNewWordScreen => openNewWordScreenSC.sink;

  void _initListeners() {
    openNewWordScreenSC.stream.listen((_) => _openNewWordScreen());
  }

  void _openNewWordScreen() {
    navigator.push(NewWordScreenRoute());
  }

  @override
  void dispose() {
    openNewWordScreenSC.close();

    super.dispose();
  }
}
