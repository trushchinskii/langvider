import 'package:langvider/src/interactor/learning/learning_interactor.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/base/state_management/state/action.dart';
import 'package:langvider/src/ui/base/state_management/state/loading_state_stream.dart';
import 'package:langvider/src/ui/screen/debug/debug_screen_route.dart';
import 'package:langvider/src/ui/screen/dictionary/dictionary_screen_route.dart';
import 'package:langvider/src/ui/screen/learning/learning_screen_route.dart';
import 'package:langvider/src/ui/screen/new_word/new_word_screen_route.dart';
import 'package:langvider/src/ui/screen/trainings/trainings_screen_route.dart';
import 'package:pedantic/pedantic.dart';

class MainScreenWm extends BaseWidgetModel {
  MainScreenWm(
    WmDependencies dependencies,
    this._learningInteractor,
  ) : super(dependencies) {
    loadLearningWords();
  }

  final LearningInteractor _learningInteractor;

  final learningDateState = LoadingStateStream<DateTime>(
    LoadingState.loading(),
  );

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

  Future<void> loadLearningWords() async {
    try {
      learningDateState.loading();

      final hasLearningWords = await _learningInteractor.hasLearningWords;
      if (hasLearningWords) {
        learningDateState.content(DateTime.now());
      } else {
        final DateTime nextLearningDate =
            await _learningInteractor.getNextLearningDate();
        learningDateState.content(nextLearningDate);
      }
    } on Exception catch (e) {
      handleError(e);
    }
  }

  Future<void> _openNewWordScreen() async {
    await navigator.push(NewWordScreenRoute());
    unawaited(loadLearningWords());
  }

  Future<void> _openDictionaryScreen() async {
    await navigator.push(DictionaryScreenRoute());
    unawaited(loadLearningWords());
  }

  void _openTrainingsScreen() {
    navigator.push(TrainingsScreenRoute());
  }

  Future<void> _openLearningWordsScreen() async {
    await navigator.push(LearningScreenRoute());
    unawaited(loadLearningWords());
  }

  void _openDebugScreen() {
    navigator.push(DebugScreenRoute());
  }
}
