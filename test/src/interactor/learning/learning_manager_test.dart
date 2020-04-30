import 'package:flutter_test/flutter_test.dart';
import 'package:langvider/src/domain/word.dart';
import 'package:langvider/src/interactor/dictionary/dictionary_interactor.dart';
import 'package:langvider/src/interactor/learning/learning_manager.dart';
import 'package:mockito/mockito.dart';

import '../../../mocks.dart';

void main() {
  DictionaryInteractor dictionaryInteractorMock;
  LearningManager learningManager;

  setUp(() {
    dictionaryInteractorMock = DictionaryInteractorMock();
    learningManager = LearningManager(dictionaryInteractorMock);
  });
  group('LearningManager.getLearningWords() test', () {
    test('Test empty words list', () async {
      when(
        dictionaryInteractorMock.getCachedWords(updateIfEmpty: true),
      ).thenAnswer((_) => Future.value([]));

      expect(await learningManager.getLearningWords(), isEmpty);
    });
    test('Test words which can learn', () async {
      final now = DateTime.now().add(const Duration(seconds: -10));
      final List<Word> learningWords = [
        Word(
          id: '0',
          text: 'text 0',
          translation: 'translation 0',
          memoryPoints: 0,
          createdDate: now,
          nextLearningDate: now,
        ),
        Word(
          id: '01',
          text: 'text 01',
          translation: 'translation 01',
          memoryPoints: 0,
          createdDate: now.add(const Duration(minutes: -30)),
          nextLearningDate: now,
        ),
        Word(
          id: '1',
          text: 'text 1',
          translation: 'translation 1',
          memoryPoints: 1,
          createdDate: now.add(const Duration(hours: -8)),
          nextLearningDate: now,
        ),
        Word(
          id: '11',
          text: 'text 11',
          translation: 'translation 11',
          memoryPoints: 1,
          createdDate: now.add(const Duration(hours: -9)),
          nextLearningDate: now,
        ),
        Word(
          id: '2',
          text: 'text 2',
          translation: 'translation 2',
          memoryPoints: 2,
          createdDate: DateTime(now.year, now.month, now.day + 1),
          nextLearningDate: now,
        ),
        Word(
          id: '3',
          text: 'text 3',
          translation: 'translation 3',
          memoryPoints: 3,
          createdDate: DateTime(now.year, now.month, now.day + 2),
          nextLearningDate: now,
        ),
        Word(
          id: '4',
          text: 'text 4',
          translation: 'translation 4',
          memoryPoints: 4,
          createdDate: DateTime(now.year, now.month, now.day + 7),
          nextLearningDate: now,
        ),
        Word(
          id: '5',
          text: 'text 5',
          translation: 'translation 5',
          memoryPoints: 5,
          createdDate: DateTime(now.year, now.month, now.day + 14),
          nextLearningDate: now,
        ),
        Word(
          id: '6',
          text: 'text 6',
          translation: 'translation 6',
          memoryPoints: 4,
          createdDate: DateTime(now.year, now.month, now.day + 30),
          nextLearningDate: now,
        ),
        Word(
          id: '7',
          text: 'text 7',
          translation: 'translation 7',
          memoryPoints: 7,
          createdDate: DateTime(now.year, now.month, now.day + 60),
          nextLearningDate: now,
        ),
      ];
      final List<Word> notLearningWords = [
        Word(
          id: '8',
          text: 'text 8',
          translation: 'translation 8',
          memoryPoints: 8,
          createdDate: now,
          nextLearningDate: DateTime(now.year, now.month),
        ),
        Word(
          id: '9',
          text: 'text 9',
          translation: 'translation 9',
          memoryPoints: 1,
          createdDate: now,
          nextLearningDate: now.add(const Duration(hours: 3)),
        ),
        Word(
          id: '10',
          text: 'text 10',
          translation: 'translation 10',
          memoryPoints: 1,
          createdDate: now,
          nextLearningDate: now.add(const Duration(hours: 6)),
        ),
        Word(
          id: '11',
          text: 'text 11',
          translation: 'translation 11',
          memoryPoints: 2,
          createdDate: now,
          nextLearningDate: now.add(const Duration(days: 2)),
        ),
      ];

      when(
        dictionaryInteractorMock.getCachedWords(updateIfEmpty: true),
      ).thenAnswer((_) => Future.value([
            ...learningWords,
            ...notLearningWords,
          ]));

      expect(await learningManager.getLearningWords(), equals(learningWords));
    });

    test("Test words that can't be learned", () async {
      final now = DateTime.now().add(const Duration(seconds: -10));

      final List<Word> notLearningWords = [
        Word(
          id: '1',
          text: 'text 1',
          translation: 'translation 1',
          memoryPoints: 1,
          createdDate: now,
          nextLearningDate: now.add(const Duration(hours: 6)),
        ),
        Word(
          id: '2',
          text: 'text 2',
          translation: 'translation 2',
          memoryPoints: 2,
          createdDate: now,
          nextLearningDate: now.add(const Duration(hours: 8)),
        ),
        Word(
          id: '3',
          text: 'text 3',
          translation: 'translation 3',
          memoryPoints: 3,
          createdDate: now,
          nextLearningDate: now.add(const Duration(days: 1)),
        ),
        Word(
          id: '4',
          text: 'text 4',
          translation: 'translation 4',
          memoryPoints: 4,
          createdDate: now,
          nextLearningDate: now.add(const Duration(days: 5)),
        ),
        Word(
          id: '5',
          text: 'text 5',
          translation: 'translation 5',
          memoryPoints: 5,
          createdDate: now,
          nextLearningDate: now.add(const Duration(days: 12)),
        ),
        Word(
          id: '6',
          text: 'text 6',
          translation: 'translation 6',
          memoryPoints: 6,
          createdDate: now,
          nextLearningDate: now.add(const Duration(days: 25)),
        ),
        Word(
          id: '7',
          text: 'text 7',
          translation: 'translation 7',
          memoryPoints: 7,
          createdDate: now,
          nextLearningDate: now.add(const Duration(days: 45)),
        ),
      ];

      when(
        dictionaryInteractorMock.getCachedWords(updateIfEmpty: true),
      ).thenAnswer((_) => Future.value(notLearningWords));

      expect(await learningManager.getLearningWords(), isEmpty);
    });
  });

  group('LearningManager.saveLearnedWord() test', () {
    test('Test saving learned word', () async {
      final now = DateTime.now();
      final newWord = Word.create(
        text: 'text',
        translation: 'translation',
      );

      final wordInMiddleOfLearning = Word(
        text: 'text',
        translation: 'translation',
        memoryPoints: 4,
        nextLearningDate: now,
      );

      final Word savedNewWord = await learningManager.saveLearnedWord(newWord);
      final Word savedWordInMiddleOfLearning =
          await learningManager.saveLearnedWord(wordInMiddleOfLearning);

      expect(savedNewWord.memoryPoints, equals(1));
      expect(
        savedNewWord.nextLearningDate.isAfter(
              now
                  .add(const Duration(seconds: -20))
                  .add(const Duration(hours: 8)),
            ) &&
            savedNewWord.nextLearningDate.isBefore(
              now
                  .add(const Duration(seconds: 20))
                  .add(const Duration(hours: 8)),
            ),
        isTrue,
      );

      expect(savedWordInMiddleOfLearning.memoryPoints, equals(5));
      expect(
        savedWordInMiddleOfLearning.nextLearningDate.isAfter(
              now.add(const Duration(days: 13)),
            ) &&
            savedWordInMiddleOfLearning.nextLearningDate.isBefore(
              now.add(const Duration(days: 15)),
            ),
        isTrue,
      );
    });

    test('Test saving already learned word', () async {
      final now = DateTime.now();
      final alreadyLearnedWord = Word(
        text: 'text',
        translation: 'translation',
        memoryPoints: 8,
        nextLearningDate: now,
      );

      final Word savedAlreadyLearnedWord =
          await learningManager.saveLearnedWord(alreadyLearnedWord);
      expect(
        savedAlreadyLearnedWord.memoryPoints,
        equals(9),
      );
      expect(
        savedAlreadyLearnedWord.nextLearningDate,
        equals(now),
      );
    });
  });

  group('LearningManager.getNextLearningDate() test', () {
    test('Test empty words from dictionary', () async {
      when(
        dictionaryInteractorMock.getCachedWords(updateIfEmpty: true),
      ).thenAnswer((_) => Future.value([]));
      expect(await learningManager.getNextLearningDate(), isNull);
    });
    test('Test with learning words in past', () async {
      final now = DateTime.now();
      when(
        dictionaryInteractorMock.getCachedWords(updateIfEmpty: true),
      ).thenAnswer((_) => Future.value([
            Word(
              text: 'text',
              translation: 'translation',
              memoryPoints: 8,
              nextLearningDate: now,
            ),
            Word(
              text: 'text',
              translation: 'translation',
              memoryPoints: 5,
              nextLearningDate: now.add(const Duration(hours: -5)),
            ),
            Word(
              text: 'text',
              translation: 'translation',
              memoryPoints: 2,
              nextLearningDate: now.add(const Duration(hours: -10)),
            ),
            Word(
              text: 'text',
              translation: 'translation',
              memoryPoints: 1,
              nextLearningDate: now.add(const Duration(hours: 15)),
            ),
          ]));

      final nextLearningDate = await learningManager.getNextLearningDate();

      expect(
        nextLearningDate.isAfter(now.add(const Duration(seconds: -10))) &&
            nextLearningDate.isBefore(now.add(const Duration(seconds: 10))),
        isTrue,
      );
    });
    test('Test with learning words in future', () async {
      final dateInFuture = DateTime.now().add(const Duration(days: 2));
      when(
        dictionaryInteractorMock.getCachedWords(updateIfEmpty: true),
      ).thenAnswer((_) => Future.value([
            Word(
              text: 'text',
              translation: 'translation',
              memoryPoints: 8,
              nextLearningDate: dateInFuture.add(const Duration(hours: -12)),
            ),
            Word(
              text: 'text',
              translation: 'translation',
              memoryPoints: 5,
              nextLearningDate: dateInFuture,
            ),
            Word(
              text: 'text',
              translation: 'translation',
              memoryPoints: 2,
              nextLearningDate: dateInFuture.add(const Duration(hours: 5)),
            ),
            Word(
              text: 'text',
              translation: 'translation',
              memoryPoints: 1,
              nextLearningDate: dateInFuture.add(const Duration(hours: 10)),
            ),
          ]));

      final nextLearningDate = await learningManager.getNextLearningDate();

      expect(
        nextLearningDate
                .isAfter(dateInFuture.add(const Duration(seconds: -10))) &&
            nextLearningDate
                .isBefore(dateInFuture.add(const Duration(seconds: 10))),
        isTrue,
      );
    });
    test('Test with learning wordswithout', () async {
      final now = DateTime.now();

      when(
        dictionaryInteractorMock.getCachedWords(updateIfEmpty: true),
      ).thenAnswer((_) => Future.value([
            Word(
              text: 'text',
              translation: 'translation',
              memoryPoints: 8,
              nextLearningDate: now,
            ),
            Word(
              text: 'text',
              translation: 'translation',
              memoryPoints: 9,
              nextLearningDate: now.add(const Duration(hours: -5)),
            ),
            Word(
              text: 'text',
              translation: 'translation',
              memoryPoints: 10,
              nextLearningDate: now.add(const Duration(hours: -10)),
            ),
            Word(
              text: 'text',
              translation: 'translation',
              memoryPoints: 11,
              nextLearningDate: now.add(const Duration(hours: 15)),
            ),
          ]));

      expect(
        await learningManager.getNextLearningDate(),
        isNull,
      );
    });
  });
}
