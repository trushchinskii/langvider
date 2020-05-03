import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:langvider/src/domain/training_data_item.dart';
import 'package:langvider/src/domain/training_type.dart';
import 'package:langvider/src/domain/word.dart';
import 'package:langvider/src/interactor/dictionary/dictionary_interactor.dart';

const wordsCountByTraining = 10;
const maxAnswersCount = 4;

class TrainingInteractor {
  TrainingInteractor(
    this._dictionaryInteractor,
  );

  final DictionaryInteractor _dictionaryInteractor;

  final _random = Random();

  Future<List<TrainingDataItem>> getTrainingData(
    TrainingType trainingType,
  ) async {
    final List<Word> words = await _dictionaryInteractor.getCachedWords(
      updateIfEmpty: true,
    );
    final List<Word> sortedWords = _sortWords(trainingType, words);
    final List<Word> trainingWords = sortedWords.length > wordsCountByTraining
        ? sortedWords.sublist(0, wordsCountByTraining)
        : sortedWords;

    final List<List<Word>> answers = createAnswers(trainingWords, sortedWords);

    return List<TrainingDataItem>.generate(
      trainingWords.length,
      (index) => TrainingDataItem(trainingWords[index], answers[index]),
    );
  }

  bool isAnswerCorrect({
    @required TrainingType trainingType,
    @required Word word,
    @required Object answer,
    bool updateWordOnServer = false,
  }) {
    bool isCorrect = false;
    switch (trainingType) {
      case TrainingType.selectTextTranslation:
        {
          if (answer is Word) {
            isCorrect = _compareAnswersString(
              word.translation,
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
            isCorrect = _compareAnswersString(
              word.text,
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
            isCorrect = _compareAnswersString(
              word.translation,
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
            isCorrect = _compareAnswersString(
              word.text,
              answer,
            );
          } else {
            throw Exception('Answer must be String');
          }
        }
        break;
    }

    if (updateWordOnServer) {
      final int earnedTrainingPoints = isCorrect ? 1 : -1;
      word
        ..trainingPoints = word.trainingPoints + earnedTrainingPoints
        ..lastTrainingDate = DateTime.now();

      if (isCorrect) {
        word.trainingProgress.progress[trainingType] =
            word.trainingProgress.progress[trainingType] + 1;
      }

      _dictionaryInteractor.updateWord(word);
    }

    return isCorrect;
  }

  List<List<Word>> createAnswers(
    List<Word> words,
    List<Word> allWords,
  ) {
    final List<List<Word>> result = [];

    for (Word word in words) {
      final answers = <Word>[word];
      final answerCount =
          words.length > maxAnswersCount ? maxAnswersCount : words.length;

      for (int i = 1; i < answerCount; i++) {
        answers.add(_getRandomWord(answers, allWords));
      }
      answers.shuffle(_random);
      result.add(answers);
    }

    return result;
  }

  Word _getRandomWord(List<Word> existedWords, List<Word> allWords) {
    final index = _random.nextInt(allWords.length);
    final word = allWords[index];

    if (existedWords.contains(word)) {
      return _getRandomWord(existedWords, allWords);
    } else {
      return word;
    }
  }

  List<Word> _sortWords(
    TrainingType trainingType,
    List<Word> _words,
  ) {
    _words.sort((firstWord, secondWord) {
      final int firstTrainingProgress =
          firstWord.trainingProgress.progress[trainingType];
      final int secondTrainingProgress =
          secondWord.trainingProgress.progress[trainingType];

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

  bool _compareAnswersString(String str1, String str2) {
    return str1.toLowerCase().trim() == str2.toLowerCase().trim();
  }
}
