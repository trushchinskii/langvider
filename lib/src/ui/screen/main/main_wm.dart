import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/base/state_management/state/action.dart';
import 'package:langvider/src/ui/screen/dictionary/dictionary_screen_route.dart';
import 'package:langvider/src/ui/screen/new_word/new_word_screen_route.dart';
import 'package:langvider/src/ui/screen/trainings/trainings_screen_route.dart';

class MainScreenWm extends BaseWidgetModel {
  MainScreenWm(WmDependencies dependencies) : super(dependencies);

  final openNewWordScreenAction = Action();
  final openDictionaryScreenAction = Action();
  final openTrainingsScreenAction = Action();

  @override
  void initListeners() {
    listen(openNewWordScreenAction, (_) => _openNewWordScreen());
    listen(openDictionaryScreenAction, (_) => _openDictionaryScreen());
    listen(openTrainingsScreenAction, (_) => _openTrainingsScreen());
  }

  void _openNewWordScreen() {
    navigator.push(NewWordScreenRoute());
  }

  void _openDictionaryScreen() {
    navigator.push(DictionaryScreenRoute());
  }

  void _openTrainingsScreen() {
    navigator.push(TrainingsScreenRoute());
  }
}
