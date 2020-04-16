import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langvider/src/domain/word.dart';
import 'package:langvider/src/ui/utils/transformable.dart';

const _textFieldName = 'text';
const _translationFieldName = 'translation';
const _scoreFieldName = 'score';
const _createdDateFieldName = 'createdDate';
const _updatedDateFieldName = 'updatedDate';
const _lastLearnedDateFieldName = 'lastLearnedDate';
const _userIdFieldName = 'userId';

class WordDto implements Transformable<Word> {
  WordDto._({
    this.id,
    this.text,
    this.translation,
    this.score,
    this.createdDate,
    this.updatedDate,
    this.lastLearnedDate,
    this.userId,
  });

  WordDto.fromWord(Word word)
      : this._(
          id: word.id,
          text: word.text,
          translation: word.translation,
          score: word.score,
          createdDate: word.createdDate,
          updatedDate: word.updatedDate,
          lastLearnedDate: word.lastLearnedDate,
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
          score: _getDataFromSnapshot(
            snapshot,
            _scoreFieldName,
          ),
          createdDate: _getDataFromSnapshot(
            snapshot,
            _createdDateFieldName,
          ),
          updatedDate: _getDataFromSnapshot(
            snapshot,
            _updatedDateFieldName,
          ),
          lastLearnedDate: _getDataFromSnapshot(
            snapshot,
            _lastLearnedDateFieldName,
          ),
          userId: _getDataFromSnapshot(
            snapshot,
            _userIdFieldName,
          ),
        );

  final String id;
  final String text;
  final String translation;
  final int score;
  final DateTime createdDate;
  final DateTime updatedDate;
  final DateTime lastLearnedDate;
  final String userId;

  Map<String, Object> get map => {
        _textFieldName: text,
        _translationFieldName: translation,
        _scoreFieldName: score,
        _createdDateFieldName: createdDate,
        _updatedDateFieldName: updatedDate,
        _lastLearnedDateFieldName: lastLearnedDate,
        _userIdFieldName: userId,
      };

  @override
  Word transform() => Word(
        id: id,
        text: text,
        translation: translation,
        score: score,
        createdDate: createdDate,
        updatedDate: updatedDate,
        lastLearnedDate: lastLearnedDate,
        userId: userId,
      );
}

T _getDataFromSnapshot<T>(
  DocumentSnapshot snapshot,
  String fieldName,
) {
  final dynamic data = snapshot.data[fieldName];

  if (data is T) {
    return data;
  } else {
    return null;
  }
}
