import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/base/state_management/state/action.dart';
import 'package:langvider/src/ui/screen/new_word/new_word_screen_route.dart';

class MainScreenWm extends BaseWidgetModel {
  MainScreenWm(WmDependencies dependencies) : super(dependencies);

  final openNewWordScreen = Action();

  @override
  void initListeners() {
    listen(openNewWordScreen, (_) => _openNewWordScreen());
  }

  void _openNewWordScreen() {
    navigator.push(NewWordScreenRoute());
  }
}
