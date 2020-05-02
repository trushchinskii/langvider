import 'package:langvider/src/domain/training_data_item.dart';
import 'package:langvider/src/domain/training_type.dart';
import 'package:langvider/src/domain/word.dart';
import 'package:langvider/src/interactor/common/logger/logger.dart';
import 'package:langvider/src/interactor/training/training_interactor.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/base/state_management/state/action.dart';
import 'package:langvider/src/ui/base/state_management/state/loading_state_stream.dart';
import 'package:langvider/src/ui/screen/trainings/model/training_ui_data.dart';

const _delayBetweenWordsTraining = Duration(milliseconds: 800);

class SelectingTrainingScreenWm extends BaseWidgetModel {
  SelectingTrainingScreenWm(
    WmDependencies dependencies,
    this._trainingType,
    this._trainingInteractor,
  ) : super(dependencies);

  final TrainingType _trainingType;
  final _trainingUiData = <TrainingUiDataItem>[];
  final TrainingInteractor _trainingInteractor;

  final trainingUiDataItemState = LoadingStateStream<TrainingUiDataItem>(
    LoadingState.loading(),
  );

  final answerAction = Action<Word>();
  final completeAction = Action();

  @override
  void onAttached() {
    _loadTrainingData();
  }

  @override
  void initListeners() {
    listen(answerAction, _checkAnswer);
    listen(completeAction, (_) => _completeTraining());
  }

  Future<void> _loadTrainingData() async {
    trainingUiDataItemState.loading();

    final List<TrainingUiDataItem> _uiData = await _getTrainingWords();
    _trainingUiData.clear();
    _trainingUiData.addAll(_uiData);

    _nextTrainingUiDataItem();
  }

  Future<List<TrainingUiDataItem>> _getTrainingWords() async {
    try {
      final List<TrainingDataItem> trainingData =
          await _trainingInteractor.getTrainingData(_trainingType);

      return trainingData.map(
        (data) {
          return TrainingUiDataItem(
            _trainingType,
            TrainingUiDataItemStatus.inProgress,
            data,
          );
        },
      ).toList()
        ..add(TrainingUiDataItem.completed(_trainingType));
    } on Exception catch (e) {
      handleError(e);
    }

    return [];
  }

  void _nextTrainingUiDataItem() {
    if (_trainingUiData.isEmpty) {
      log.e('TrainingUiData is empty for training $_trainingType');
      return;
    }

    final lastData = trainingUiDataItemState.value;
    if (trainingUiDataItemState.value?.data == null) {
      trainingUiDataItemState.accept(LoadingState.content(_trainingUiData[0]));
    } else if (lastData.data.status == TrainingUiDataItemStatus.complete) {
      log.e('Training $_trainingType already completed');
      return;
    } else {
      final int lastIndex = _trainingUiData.indexWhere((data) {
        return data.data.word.id == lastData.data.data.word.id;
      });
      trainingUiDataItemState.accept(
        LoadingState.content(_trainingUiData[lastIndex + 1]),
      );
    }
  }

  Future<void> _checkAnswer(Word answer) async {
    final isAnswerCorrect = _trainingInteractor.isAnswerCorrect(
      trainingType: _trainingType,
      word: trainingUiDataItemState.value.data.data.word,
      answer: answer,
      updateWordOnServer: true,
    );
    trainingUiDataItemState.accept(
      LoadingState.content(
        trainingUiDataItemState.value.data.copy(
          isAnswerCorrect: isAnswerCorrect,
        ),
      ),
    );

    await Future.delayed(_delayBetweenWordsTraining);

    _nextTrainingUiDataItem();
  }

  void _completeTraining() {
    navigator.pop();
  }
}
