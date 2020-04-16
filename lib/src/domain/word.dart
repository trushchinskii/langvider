import 'package:flutter/foundation.dart';

@immutable
class Word {
  Word({
    @required this.text,
    @required this.translation,
    @required this.score,
    this.id,
    this.createdDate,
    this.updatedDate,
    this.lastLearnedDate,
    this.userId,
  })  : assert(text != null && translation != null),
        assert(score != null);

  final String id;
  final String text;
  final String translation;
  final int score;
  final DateTime createdDate;
  final DateTime updatedDate;
  final DateTime lastLearnedDate;
  final String userId;

  Word copy({
    String id,
    String text,
    String translation,
    int score,
    DateTime createdDate,
    DateTime updatedDate,
    DateTime lastLearnedDate,
    String userId,
  }) {
    return Word(
      id: id ?? this.id,
      text: text ?? this.text,
      translation: translation ?? this.translation,
      score: score ?? this.score,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
      lastLearnedDate: lastLearnedDate ?? this.lastLearnedDate,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() => {
        'id': id,
        'text': text,
        'translation': translation,
        'score': score,
        'createdDate': createdDate,
        'updatedDate': updatedDate,
        'lastLearnedDate': lastLearnedDate,
        'userId': userId,
      }.toString();
}
