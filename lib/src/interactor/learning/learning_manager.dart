import 'package:langvider/src/domain/word.dart';
import 'package:langvider/src/interactor/common/logger/logger.dart';
import 'package:langvider/src/interactor/dictionary/dictionary_interactor.dart';

const _repeatPeriods = {
  0: Duration(seconds: 0),
  1: Duration(hours: 8),
  2: Duration(days: 1),
  3: Duration(days: 2),
  4: Duration(days: 7),
  5: Duration(days: 14),
  6: Duration(days: 30),
  7: Duration(days: 60),
};

/// Additional time to group learning words
const _additionalTime = {
  0: Duration(hours: -1),
  1: Duration(hours: -2),
};

class LearningManager {
  LearningManager(this._dictionaryInteractor);

  final DictionaryInteractor _dictionaryInteractor;

  Future<bool> get hasLearningWords async {
    final List<Word> words = await getLearningWords();
    return words.isNotEmpty;
  }

  Future<List<Word>> getLearningWords() async {
    final List<Word> words = await _dictionaryInteractor.getCachedWords(
      updateIfEmpty: true,
    );

    return _calculateLearningWords(words);
  }

  Future<Word> saveLearnedWord(Word word) async {
    final isAlreadyLearned = word.memoryPoints < _repeatPeriods.length;
    final nextLearningPoints = word.memoryPoints + 1;

    word.memoryPoints = nextLearningPoints;
    if (isAlreadyLearned) {
      word.nextLearningDate = DateTime.now().add(
        _repeatPeriods[nextLearningPoints],
      );
    }

    await _dictionaryInteractor.updateWord(word);
    return word;
  }

  Future<DateTime> getNextLearningDate() async {
    final now = DateTime.now();
    final List<Word> words = await _dictionaryInteractor.getCachedWords(
      updateIfEmpty: true,
    );

    if (words.isEmpty) return null;
    final learningWords = words
        .where(
          (word) => word.memoryPoints < _repeatPeriods.length,
        )
        .toList();
    learningWords.sort(
      (w1, w2) => w1.nextLearningDate.compareTo(w2.nextLearningDate),
    );

    if (learningWords.isNotEmpty) {
      final Word firstWord = learningWords[0];
      if (firstWord.nextLearningDate.isBefore(now)) {
        return now;
      } else {
        return firstWord.nextLearningDate;
      }
    } else {
      return null;
    }
  }

  List<Word> _calculateLearningWords(List<Word> words) {
    final now = DateTime.now();

    final List<Word> learningWords = words.where((word) {
      if (word.nextLearningDate == null || word.memoryPoints == null) {
        log.e("Can't define learning status for word: $word");
        return false;
      }
      final DateTime nextLearningDate =
          _additionalTime.keys.contains(word.memoryPoints)
              ? word.nextLearningDate.add(_additionalTime[word.memoryPoints])
              : word.nextLearningDate;

      return nextLearningDate.isBefore(now) &&
          word.memoryPoints != _repeatPeriods.length;
    }).toList();

    return learningWords;
  }
}
