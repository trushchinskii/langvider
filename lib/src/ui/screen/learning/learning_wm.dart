import 'package:langvider/src/domain/training_data_item.dart';
import 'package:langvider/src/domain/training_type.dart';
import 'package:langvider/src/domain/word.dart';
import 'package:langvider/src/interactor/common/logger/logger.dart';
import 'package:langvider/src/interactor/learning/learning_interactor.dart';
import 'package:langvider/src/interactor/training/training_interactor.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/base/state_management/state/action.dart';
import 'package:langvider/src/ui/base/state_management/state/loading_state_stream.dart';
import 'package:langvider/src/ui/screen/trainings/model/training_ui_data.dart';
import 'package:langvider/src/ui/screen/trainings/selecting/selecting_training_wm.dart';
import 'package:pedantic/pedantic.dart';

class LearningScreenWm extends BaseWidgetModel {
  LearningScreenWm(
    WmDependencies dependencies,
    this._learningInteractor,
    this._trainingInteractor,
  ) : super(dependencies);

  final LearningInteractor _learningInteractor;
  final TrainingInteractor _trainingInteractor;
  final List<TrainingUiDataItem> _learningUiData = [];

  final uiDataItemState = LoadingStateStream<TrainingUiDataItem>(
    LoadingState.loading(),
  );

  final answerAction = Action<Word>();
  final completeAction = Action();

  @override
  void onAttached() {
    super.onAttached();

    _loadLearningData();
  }

  @override
  void initListeners() {
    listen(answerAction, _checkAnswer);
    listen(completeAction, (_) => _completeLearning());
  }

  Future<void> _loadLearningData() async {
    final List<TrainingDataItem> data =
        await _learningInteractor.getTrainingUiData();

    _learningUiData.clear();
    for (TrainingDataItem dataItem in data) {
      _learningUiData.add(TrainingUiDataItem(TrainingType.selectTextTranslation,
          TrainingUiDataItemStatus.inProgress, dataItem));
    }
    _learningUiData.add(
      TrainingUiDataItem.completed(
        TrainingType.selectTextTranslation,
      ),
    );

    _nextTrainingUiDataItem();
  }

  void _nextTrainingUiDataItem() {
    if (_learningUiData.isEmpty) {
      log.e('LearningUiData is empty');
      return;
    }

    final lastData = uiDataItemState.value;
    if (uiDataItemState.value?.data == null) {
      uiDataItemState.accept(LoadingState.content(_learningUiData[0]));
    } else if (lastData.data.status == TrainingUiDataItemStatus.complete) {
      log.e('Training ${lastData.data.status} already completed');
      return;
    } else {
      final int lastIndex = _learningUiData.indexWhere((data) {
        return data.data.word.id == lastData.data.data.word.id &&
            data.trainingType == lastData.data.trainingType;
      });
      uiDataItemState.accept(
        LoadingState.content(_learningUiData[lastIndex + 1]),
      );
    }
  }

  Future<void> _checkAnswer(Word answer) async {
    final isAnswerCorrect = _trainingInteractor.isAnswerCorrect(
      trainingType: uiDataItemState.value.data.trainingType,
      word: uiDataItemState.value.data.data.word,
      answer: answer,
    );

    if (isAnswerCorrect) {
      unawaited(_learningInteractor.saveLearnedWord(
        uiDataItemState.value.data.data.word,
      ));
    }

    uiDataItemState.accept(
      LoadingState.content(
        uiDataItemState.value.data.copy(
          isAnswerCorrect: isAnswerCorrect,
        ),
      ),
    );

    await Future.delayed(delayBetweenWordsTraining);

    _nextTrainingUiDataItem();
  }

  void _completeLearning() {
    navigator.pop();
  }
}
