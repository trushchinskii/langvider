import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langvider/src/domain/word.dart';
import 'package:langvider/src/interactor/dictionary/repository/model/training_progress_dto.dart';
import 'package:langvider/src/ui/utils/transformable.dart';

const _textFieldName = 'text';
const _translationFieldName = 'translation';
const _memoryPointsFieldName = 'memoryPoints';
const _trainingPointsFieldName = 'trainingPoints';
const _trainingProgressFieldName = 'trainingProgress';
const createdDateFieldName = 'createdDate';
const _lastLearningDateFieldName = 'lastLearningDate';
const _nextLearningDateFieldName = 'nextLearningDate';
const _lastTrainingDateDateFieldName = 'lastTrainingDate';
const _userIdFieldName = 'userId';

class WordDto implements Transformable<Word> {
  WordDto._({
    this.id,
    this.text,
    this.translation,
    this.memoryPoints,
    this.trainingPoints,
    this.trainingProgress,
    this.createdDate,
    this.lastLearningDate,
    this.nextLearningDate,
    this.lastTrainingDate,
    this.userId,
  });

  WordDto.fromWord(Word word)
      : this._(
          id: word.id,
          text: word.text,
          translation: word.translation,
          memoryPoints: word.memoryPoints,
          trainingPoints: word.trainingPoints,
          trainingProgress: TrainingProgressDto(word.trainingProgress),
          createdDate: word.createdDate,
          lastLearningDate: word.lastLearningDate,
          nextLearningDate: word.nextLearningDate,
          lastTrainingDate: word.lastTrainingDate,
          userId: word.userId,
        );

  WordDto.fromSnapshot(DocumentSnapshot snapshot)
      : this._(
          id: snapshot.documentID,
          text: _getDataFromSnapshot(
            snapshot,
            _textFieldName,
          ),
          translation: _getDataFromSnapshot(
            snapshot,
            _translationFieldName,
          ),
          memoryPoints: _getDataFromSnapshot(
            snapshot,
            _memoryPointsFieldName,
          ),
          trainingPoints: _getDataFromSnapshot(
            snapshot,
            _trainingPointsFieldName,
          ),
          trainingProgress: TrainingProgressDto.fromJson(
            _getDataFromSnapshot<Map>(
              snapshot,
              _trainingProgressFieldName,
            ),
          ),
          createdDate: _getDataFromSnapshot<Timestamp>(
            snapshot,
            createdDateFieldName,
          )?.toDate(),
          lastLearningDate: _getDataFromSnapshot<Timestamp>(
            snapshot,
            _lastLearningDateFieldName,
          )?.toDate(),
          nextLearningDate: _getDataFromSnapshot<Timestamp>(
            snapshot,
            _nextLearningDateFieldName,
          )?.toDate(),
          lastTrainingDate: _getDataFromSnapshot<Timestamp>(
            snapshot,
            _lastTrainingDateDateFieldName,
          )?.toDate(),
          userId: _getDataFromSnapshot(
            snapshot,
            _userIdFieldName,
          ),
        );

  final String id;
  final String text;
  final String translation;
  final int memoryPoints;
  final int trainingPoints;
  final TrainingProgressDto trainingProgress;
  final DateTime createdDate;
  final DateTime lastLearningDate;
  final DateTime nextLearningDate;
  final DateTime lastTrainingDate;
  final String userId;

  Map<String, Object> get map => {
        _textFieldName: text,
        _translationFieldName: translation,
        _memoryPointsFieldName: memoryPoints,
        _trainingPointsFieldName: trainingPoints,
        _trainingProgressFieldName: trainingProgress.map,
        createdDateFieldName: createdDate,
        _lastLearningDateFieldName: lastLearningDate,
        _nextLearningDateFieldName: nextLearningDate,
        _lastTrainingDateDateFieldName: lastTrainingDate,
        _userIdFieldName: userId,
      };

  @override
  Word transform() => Word(
        id: id,
        text: text,
        translation: translation,
        memoryPoints: memoryPoints,
        trainingPoints: trainingPoints,
        trainingProgress: trainingProgress.transform(),
        createdDate: createdDate,
        lastLearningDate: lastLearningDate,
        nextLearningDate: nextLearningDate,
        lastTrainingDate: lastTrainingDate,
        userId: userId,
      );
}

T _getDataFromSnapshot<T>(
  DocumentSnapshot snapshot,
  String fieldName,
) {
  final dynamic data = snapshot.data[fieldName];
  if (data == null) return null;

  if (data is T) {
    return data;
  } else {
    throw Exception(
      'Parsing WordDto. '
      'DataType : ${data.runtimeType}, fieldName : $fieldName',
    );
  }
}
