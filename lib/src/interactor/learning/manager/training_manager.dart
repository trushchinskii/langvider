import 'dart:math';

import 'package:langvider/src/domain/training_data_item.dart';
import 'package:langvider/src/domain/training_type.dart';
import 'package:langvider/src/domain/word.dart';

const wordsCountByTraining = 10;
const maxAnswersCount = 4;

const _trainingsWithAnswers = [
  TrainingType.selectTextTranslation,
  TrainingType.selectTranslationText,
];

class TrainingManager {
  TrainingManager(
    this._trainingType,
    this._words,
  ) {
    _trainingData = _createTrainingData(_words);
  }

  final TrainingType _trainingType;
  final List<Word> _words;
  final random = Random();

  int _currentWordIndex = -1;
  List<TrainingDataItem> _trainingData;

  TrainingDataItem get _currentTrainingData => _trainingData[_currentWordIndex];

  TrainingDataItem getTrainingDataItem() {
    _currentWordIndex++;
    return _trainingData[_currentWordIndex];
  }

  bool isAnswerCorrect(Object answer) {
    bool isCorrect = false;
    switch (_trainingType) {
      case TrainingType.selectTextTranslation:
        {
          if (answer is Word) {
            isCorrect = compareAnswersString(
              _currentTrainingData.word.translation,
              answer.translation,
            );
          } else {
            throw Exception('Answer must be Word');
          }
        }
        break;
      case TrainingType.selectTranslationText:
        {
          if (answer is Word) {
            isCorrect = compareAnswersString(
              _currentTrainingData.word.text,
              answer.text,
            );
          } else {
            throw Exception('Answer must be Word');
          }
        }
        break;
      case TrainingType.writeTextTranslation:
        {
          if (answer is String) {
            isCorrect = compareAnswersString(
              _currentTrainingData.word.translation,
              answer,
            );
          } else {
            throw Exception('Answer must be String');
          }
        }
        break;
      case TrainingType.writeTranslationText:
        {
          if (answer is String) {
            isCorrect = compareAnswersString(
              _currentTrainingData.word.text,
              answer,
            );
          } else {
            throw Exception('Answer must be String');
          }
        }
        break;
    }

    return isCorrect;
  }

  bool isTrainingComplete() {
    final bool isComplete = _currentWordIndex == _trainingData.length - 1;
    return isComplete;
  }

  List<TrainingDataItem> _createTrainingData(List<Word> _words) {
    final List<Word> words = _sortWords(_words);
    final List<Word> trainingWords = words.length > wordsCountByTraining
        ? words.sublist(0, wordsCountByTraining)
        : words;

    if (_trainingsWithAnswers.contains(_trainingType)) {
      final List<List<Word>> answers = _createAnswers(trainingWords, words);
      return List<TrainingDataItem>.generate(
        trainingWords.length,
        (index) => TrainingDataItem(trainingWords[index], answers[index]),
      );
    } else {
      return trainingWords.map((word) => TrainingDataItem(word)).toList();
    }
  }

  List<Word> _sortWords(List<Word> _words) {
    _words.sort((firstWord, secondWord) {
      final int firstTrainingProgress =
          firstWord.trainingProgress.progress[_trainingType];
      final int secondTrainingProgress =
          secondWord.trainingProgress.progress[_trainingType];

      if (firstTrainingProgress > secondTrainingProgress) {
        return 1;
      } else if (firstTrainingProgress < secondTrainingProgress) {
        return -1;
      }

      if (firstWord.lastTrainingDate == null &&
          secondWord.lastTrainingDate != null) {
        return 1;
      } else if (firstWord.lastTrainingDate != null &&
          secondWord.lastTrainingDate == null) {
        return -1;
      } else if (firstWord.lastTrainingDate != null &&
          secondWord.lastTrainingDate != null) {
        return firstWord.lastTrainingDate.compareTo(
          secondWord.lastTrainingDate,
        );
      } else {
        return firstWord.trainingPoints.compareTo(
          secondWord.trainingPoints,
        );
      }
    });

    return _words;
  }

  List<List<Word>> _createAnswers(
    List<Word> trainingWords,
    List<Word> words,
  ) {
    final List<List<Word>> result = [];

    for (var trainingWord in trainingWords) {
      final answers = <Word>[trainingWord];
      final answerCount = trainingWords.length > maxAnswersCount
          ? maxAnswersCount
          : trainingWords.length;

      for (int i = 1; i < answerCount; i++) {
        answers.add(_getRandomWord(answers, words));
      }

      result.add(answers);
    }

    return result;
  }

  Word _getRandomWord(List<Word> existedWords, List<Word> words) {
    final index = random.nextInt(words.length);
    final word = words[index];

    if (existedWords.contains(word)) {
      return _getRandomWord(words, existedWords);
    } else {
      return word;
    }
  }

  bool compareAnswersString(String str1, String str2) {
    return str1.toLowerCase().trim() == str2.toLowerCase().trim();
  }
}
