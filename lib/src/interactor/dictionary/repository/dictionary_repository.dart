import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langvider/src/domain/word.dart';
import 'package:langvider/src/interactor/common/base/base_repository.dart';
import 'package:langvider/src/interactor/dictionary/repository/model/word_dto.dart';

const String _dictionaryCollectionName = 'dictionary';

class DictionaryRepository extends BaseRepository {
  CollectionReference get _dictionary => Firestore.instance.collection(
        _dictionaryCollectionName,
      );

  Future<void> addWord(Word word) => mapErrors(() {
        return _dictionary.add(
          WordDto.fromWord(word).map,
        );
      });

  Future<void> deleteWord(Word word) => mapErrors(() {
        return _dictionary.document(word.id).delete();
      });

  Stream<List<Word>> get wordsStream => mapErrors(() {
        return _dictionary
            .orderBy(createdDateFieldName, descending: true)
            .snapshots()
            .map(
              (querySnapshot) => querySnapshot.documents.map(
                (documentSnapshot) {
                  return WordDto.fromSnapshot(documentSnapshot).transform();
                },
              ).toList(),
            );
      });

  Future<List<Word>> getCachedWords() => mapErrors(() async {
        final querySnapshot = await _dictionary
            .orderBy(createdDateFieldName, descending: true)
            .getDocuments(source: Source.cache);

        return querySnapshot.documents.map((documentSnapshot) {
          return WordDto.fromSnapshot(documentSnapshot).transform();
        }).toList();
      });
}
