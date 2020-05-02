import 'package:flutter_test/flutter_test.dart';
import 'package:langvider/src/domain/word.dart';
import 'package:langvider/src/interactor/dictionary/dictionary_interactor.dart';
import 'package:langvider/src/interactor/training/training_interactor.dart';

import '../../../mocks.dart';

void main() {
  TrainingInteractor trainingInteractor;
  DictionaryInteractor dictionaryInteractorMock;

  setUp(() {
    dictionaryInteractorMock = DictionaryInteractorMock();
    trainingInteractor = TrainingInteractor(dictionaryInteractorMock);
  });

  group('TrainingInteractor.createAnswers() test', () {
    test('Test empty list', () async {
      trainingInteractor.createAnswers([], []);
      expect(trainingInteractor.createAnswers([], []), isEmpty);
    });

    test('Test not empty list', () async {
      final List<Word> questionWords = [];
      final List<Word> allWords = [];
      for (int i = 0; i < 10; i++) {
        questionWords.add(Word(id: '$i', text: '$i', translation: '$i'));
      }

      allWords.addAll(questionWords);

      for (int i = 10; i < 20; i++) {
        allWords.add(Word(id: '$i', text: '$i', translation: '$i'));
      }

      for (int testIndex = 0; testIndex < 1000; testIndex++) {
        final List<List<Word>> answersList = trainingInteractor.createAnswers(
          questionWords,
          allWords,
        );

        expect(questionWords.length, equals(answersList.length));

        for (int i = 0; i < questionWords.length; i++) {
          final Word word = questionWords[i];
          final List<Word> answers = answersList[i];

          final int questionWordContainsInAnswers = answers.where((answer) {
            return answer.id == word.id &&
                answer.text == word.text &&
                answer.translation == word.translation;
          }).length;
          expect(questionWordContainsInAnswers, equals(1));

          final int answersNotDuplicatedCount =
              answers.map((answer) => answer.id).toSet().length;
          expect(answersNotDuplicatedCount, equals(maxAnswersCount));
        }
      }
    });
  });
}
