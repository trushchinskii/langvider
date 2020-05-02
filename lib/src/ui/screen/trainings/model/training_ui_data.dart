import 'package:langvider/src/domain/training_data_item.dart';
import 'package:langvider/src/domain/training_type.dart';

class TrainingUiDataItem {
  TrainingUiDataItem(
    this.trainingType,
    this.status,
    this.data, {
    this.isAnswerCorrect,
  })  : assert(trainingType != null),
        assert(status != null);

  TrainingUiDataItem.completed(TrainingType trainingType)
      : this(
          trainingType,
          TrainingUiDataItemStatus.complete,
          null,
        );

  final TrainingType trainingType;
  final TrainingUiDataItemStatus status;
  final TrainingDataItem data;
  final bool isAnswerCorrect;

  TrainingUiDataItem copy({
    TrainingType trainingType,
    TrainingUiDataItemStatus status,
    TrainingDataItem data,
    bool isAnswerCorrect,
  }) {
    return TrainingUiDataItem(
      this.trainingType ?? trainingType,
      this.status ?? status,
      this.data ?? data,
      isAnswerCorrect: this.isAnswerCorrect ?? isAnswerCorrect,
    );
  }
}

enum TrainingUiDataItemStatus { inProgress, complete }
