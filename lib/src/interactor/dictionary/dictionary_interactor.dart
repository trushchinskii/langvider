import 'package:langvider/src/domain/user.dart';
import 'package:langvider/src/domain/word.dart';
import 'package:langvider/src/interactor/auth/auth_interactor.dart';
import 'package:langvider/src/interactor/dictionary/repository/dictionary_repository.dart';

class DictionaryInteractor {
  DictionaryInteractor(
    this._repository,
    this._authInteractor,
  );

  final DictionaryRepository _repository;

  final AuthInteractor _authInteractor;

  Future<void> addWord(Word word) async {
    final User user = await _authInteractor.user;

    return _repository.addWord(
      word.copy(userId: user.id),
    );
  }

  Future<List<Word>> getWords() => _repository.getWords();

  void deleteWord(Word word) => _repository.deleteWord(word);
}
