import 'package:flutter/foundation.dart';
import 'package:langvider/src/domain/training_progress.dart';

class Word {
  Word({
    @required this.text,
    @required this.translation,
    this.id,
    this.memoryPoints = 0,
    this.trainingPoints = 0,
    this.trainingProgress = const TrainingProgress.empty(),
    this.createdDate,
    this.lastMemorizedDate,
    this.lastTrainingDate,
    this.userId,
  })  : assert(text != null && text.isNotEmpty),
        assert(translation != null && translation.isNotEmpty),
        assert(memoryPoints != null);

  final String id;
  String text;
  String translation;
  int memoryPoints;
  int trainingPoints;
  final TrainingProgress trainingProgress;
  final DateTime createdDate;
  DateTime lastMemorizedDate;
  DateTime lastTrainingDate;
  String userId;

  @override
  String toString() => {
        'id': id,
        'text': text,
        'translation': translation,
        'memoryPoints': memoryPoints,
        'trainingPoints': trainingPoints,
        'trainingProgress': trainingProgress,
        'createdDate': createdDate,
        'lastMemorizedDate': lastMemorizedDate,
        'lastTrainingDate': lastTrainingDate,
        'userId': userId,
      }.toString();
}
