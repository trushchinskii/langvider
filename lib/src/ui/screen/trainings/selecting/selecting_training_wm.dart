import 'package:langvider/src/domain/training_data_item.dart';
import 'package:langvider/src/domain/training_type.dart';
import 'package:langvider/src/domain/word.dart';
import 'package:langvider/src/interactor/dictionary/dictionary_interactor.dart';
import 'package:langvider/src/interactor/learning/training_manager.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/base/state_management/state/action.dart';
import 'package:langvider/src/ui/base/state_management/state/loading_state_stream.dart';
import 'package:langvider/src/ui/screen/trainings/training_screen_type.dart';
import 'package:pedantic/pedantic.dart';

const _delayBetweenWordsTraining = Duration(milliseconds: 800);

class SelectingTrainingScreenWm extends BaseWidgetModel {
  SelectingTrainingScreenWm(
    WmDependencies dependencies,
    this._screenType,
    this._dictionaryInteractor,
  ) : super(dependencies);

  final TrainingScreenType _screenType;
  final DictionaryInteractor _dictionaryInteractor;
  TrainingManager _trainingManager;

  final trainingState = LoadingStateStream<SelectingTrainingData>(
    LoadingState.loading(),
  );

  final answerAction = Action<SelectingAnswer>();
  final completeAction = Action();

  TrainingType get _trainingType {
    switch (_screenType) {
      case TrainingScreenType.textTranslation:
        return TrainingType.selectTextTranslation;
      case TrainingScreenType.translationText:
        return TrainingType.selectTranslationText;
    }
    throw Exception('Unknown type $_screenType');
  }

  @override
  Future<void> onAttached() async {
    await _prepareTraining();
  }

  @override
  void initListeners() {
    listen(answerAction, _checkAnswer);
    listen(completeAction, (_) => _completeTraining());
  }

  Future<void> _prepareTraining() async {
    try {
      final List<Word> words = await _dictionaryInteractor.getCachedWords();
      _trainingManager = TrainingManager(_trainingType, words);

      _learnNextWord();
    } on Exception catch (e) {
      handleError(e);
    }
  }

  void _learnNextWord() {
    if (_trainingManager.isTrainingComplete()) {
      trainingState.accept(
        LoadingState.content(SelectingTrainingData.complete()),
      );
    } else {
      final trainingData = _trainingManager.getTrainingDataItem();
      trainingState.accept(
        LoadingState.content(SelectingTrainingData(trainingData)),
      );
    }
  }

  Future<void> _checkAnswer(SelectingAnswer answer) async {
    final isAnswerCorrect = _trainingManager.isAnswerCorrect(answer.word);
    answer.isCorrect = isAnswerCorrect;
    trainingState.notify();
    final Word updatedWord = _updateWord(
      trainingState.value.data.word,
      isAnswerCorrect,
    );
    unawaited(_dictionaryInteractor.updateWord(updatedWord));

    await Future.delayed(_delayBetweenWordsTraining);

    _learnNextWord();
  }

  Word _updateWord(Word word, bool isCorrect) {
    final int earnedTrainingPoints = isCorrect ? 1 : -1;
    word
      ..trainingPoints = word.trainingPoints + earnedTrainingPoints
      ..lastTrainingDate = DateTime.now();

    if (isCorrect) {
      word.trainingProgress.progress[_trainingType] =
          word.trainingProgress.progress[_trainingType] + 1;
    }

    return word;
  }

  void _completeTraining() {
    navigator.pop();
  }
}

class SelectingTrainingData {
  SelectingTrainingData(TrainingDataItem trainingDataItem)
      : word = trainingDataItem?.word,
        answers = _createAnswers(trainingDataItem?.answers),
        type = trainingDataItem != null
            ? SelectingTrainingDataType.word
            : SelectingTrainingDataType.complete;

  SelectingTrainingData.complete() : this(null);

  final Word word;
  final List<SelectingAnswer> answers;
  final SelectingTrainingDataType type;

  static List<SelectingAnswer> _createAnswers(List<Word> words) {
    if (words == null) return null;
    return words.map((word) => SelectingAnswer(word)).toList();
  }
}

enum SelectingTrainingDataType {
  word,
  complete,
}

class SelectingAnswer {
  SelectingAnswer(this.word);

  final Word word;
  bool isCorrect;
}
