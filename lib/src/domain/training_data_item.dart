import 'package:langvider/src/domain/word.dart';

class TrainingDataItem {
  TrainingDataItem(this.word, [this.answers]);

  final Word word;
  final List<Word> answers;
}
