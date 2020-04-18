import 'package:langvider/src/domain/training_type.dart';

class TrainingProgress {
  const TrainingProgress(this._progress);

  const TrainingProgress.empty()
      : this(const {
          TrainingType.selectTextTranslation: 0,
          TrainingType.selectTranslationText: 0,
          TrainingType.writeTextTranslation: 0,
          TrainingType.writeTranslationText: 0,
        });

  final Map<TrainingType, int> _progress;

  Map<TrainingType, int> get progress => _progress;
}
