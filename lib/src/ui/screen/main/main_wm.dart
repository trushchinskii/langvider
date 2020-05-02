import 'package:langvider/src/interactor/learning/learning_interactor.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/base/state_management/state/action.dart';
import 'package:langvider/src/ui/base/state_management/state/loading_state_stream.dart';
import 'package:langvider/src/ui/screen/debug/debug_screen_route.dart';
import 'package:langvider/src/ui/screen/dictionary/dictionary_screen_route.dart';
import 'package:langvider/src/ui/screen/new_word/new_word_screen_route.dart';
import 'package:langvider/src/ui/screen/trainings/trainings_screen_route.dart';

class MainScreenWm extends BaseWidgetModel {
  MainScreenWm(
    WmDependencies dependencies,
    this._learningInteractor,
  ) : super(dependencies) {
    loadLearningWords();
  }

  final LearningInteractor _learningInteractor;

  final learningWordsState = LoadingStateStream<bool>(LoadingState.loading());

  final openNewWordScreenAction = Action();
  final openDictionaryScreenAction = Action();
  final openTrainingsScreenAction = Action();
  final openLearningWordsScreenAction = Action();
  final openDebugScreenAction = Action();

  @override
  void initListeners() {
    listen(openNewWordScreenAction, (_) => _openNewWordScreen());
    listen(openDictionaryScreenAction, (_) => _openDictionaryScreen());
    listen(openTrainingsScreenAction, (_) => _openTrainingsScreen());
    listen(openLearningWordsScreenAction, (_) => _openLearningWordsScreen());
    listen(openDebugScreenAction, (_) => _openDebugScreen());
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

  void _openLearningWordsScreen() {
    // TODO open learningWords screen
  }

  void _openDebugScreen() {
    navigator.push(DebugScreenRoute());
  }

  Future<void> loadLearningWords() async {
    try {
      learningWordsState.loading();

      final hasLearningWords = await _learningInteractor.hasLearningWords;

      learningWordsState.content(hasLearningWords);
    } on Exception catch (e) {
      handleError(e);
    }
  }
}
