import 'package:langvider/src/domain/training_progress.dart';
import 'package:langvider/src/domain/training_type.dart';
import 'package:langvider/src/ui/utils/transformable.dart';

const _trainingsMap = {
  TrainingType.selectTextTranslation: 'selectTextTranslation',
  TrainingType.selectTranslationText: 'selectTranslationText',
  TrainingType.writeTextTranslation: 'writeTextTranslation',
  TrainingType.writeTranslationText: 'writeTranslationText',
};

class TrainingProgressDto implements Transformable<TrainingProgress> {
  TrainingProgressDto(
    TrainingProgress trainingProgress,
  ) : _progress = _convertTrainingProgressToMap(trainingProgress);

  TrainingProgressDto.fromJson(Map json) : _progress = _convertJsonToMap(json);

  final Map<String, int> _progress;

  @override
  TrainingProgress transform() {
    final Map<TrainingType, int> progress = _progress.map((typeStr, points) {
      final TrainingType type = _trainingsMap.entries.firstWhere((mapEntry) {
        return mapEntry.value == typeStr;
      }).key;
      return MapEntry(type, points);
    });
    return TrainingProgress(progress);
  }

  Map<String, int> get map => _progress;

  static Map<String, int> _convertTrainingProgressToMap(
    TrainingProgress trainingProgress,
  ) {
    return trainingProgress.progress.map(
      (trainingType, points) => MapEntry(_trainingsMap[trainingType], points),
    );
  }

  static Map<String, int> _convertJsonToMap(Map json) {
    return json.map<String, int>((key, value) {
      if (key is String && value is int) {
        return MapEntry(key, value);
      } else {
        throw Exception("Json for TrainingProgressDto isn't Map<String, int>");
      }
    });
  }
}
