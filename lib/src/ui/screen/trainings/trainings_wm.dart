import 'package:langvider/src/domain/training_type.dart';
import 'package:langvider/src/domain/word.dart';
import 'package:langvider/src/interactor/dictionary/dictionary_interactor.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/base/state_management/state/action.dart';
import 'package:langvider/src/ui/base/state_management/state/loading_state_stream.dart';
import 'package:langvider/src/ui/screen/trainings/selecting/selecting_training_screen_route.dart';
import 'package:langvider/src/ui/screen/trainings/writing/writing_training_screen_route.dart';

const minWordCountForTrainings = 2;

class TrainingsScreenWm extends BaseWidgetModel {
  TrainingsScreenWm(
    WmDependencies dependencies,
    this._dictionaryInteractor,
  ) : super(dependencies) {
    _checkTrainingEnable();
  }

  final DictionaryInteractor _dictionaryInteractor;

  final trainingEnablingState = LoadingStateStream<bool>(
    LoadingState.loading(),
  );

  final openSelectingTrainingAction = Action<TrainingType>();
  final openWritingTrainingAction = Action<TrainingType>();
  final reloadData = Action();

  @override
  void initListeners() {
    listen(openSelectingTrainingAction, _openSelectingTrainingScreen);
    listen(openWritingTrainingAction, _openWritingTrainingScreen);
    listen(reloadData, (_) => _checkTrainingEnable());
  }

  void _openSelectingTrainingScreen(TrainingType trainingType) {
    navigator.push(SelectingTrainingScreenRoute(trainingType));
  }

  void _openWritingTrainingScreen(TrainingType trainingType) {
    navigator.push(WritingTrainingScreenRoute(trainingType));
  }

  Future<void> _checkTrainingEnable() async {
    trainingEnablingState.loading();

    try {
      final List<Word> words = await _dictionaryInteractor.getCachedWords(
        updateIfEmpty: true,
      );
      trainingEnablingState.content(
        words != null && words.length >= minWordCountForTrainings,
      );
    } on Exception catch (e) {
      handleError(e);
      trainingEnablingState.error(e);
    }
  }
}
