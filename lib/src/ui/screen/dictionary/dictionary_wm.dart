import 'package:langvider/src/domain/word.dart';
import 'package:langvider/src/interactor/dictionary/dictionary_interactor.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/base/state_management/state/action.dart';
import 'package:langvider/src/ui/base/state_management/state/loading_state_stream.dart';
import 'package:langvider/src/ui/screen/new_word/new_word_screen_route.dart';

class DictionaryScreenWm extends BaseWidgetModel {
  DictionaryScreenWm(
    WmDependencies dependencies,
    this._dictionaryInteractor,
  ) : super(dependencies) {
    wordsStream = _dictionaryInteractor.wordsStream;
  }

  final DictionaryInteractor _dictionaryInteractor;

  final wordsState = LoadingStateStream<List<Word>>(LoadingState.content([]));
  Stream<List<Word>> wordsStream;

  final deleteWordAction = Action<Word>();
  final openNewWordScreenAction = Action();

  @override
  void initListeners() {
    listen(deleteWordAction, _deleteWord);
    listen(openNewWordScreenAction, (_) => _openNewWordScreen());
  }

  void _deleteWord(Word word) {
    try {
      _dictionaryInteractor.deleteWord(word);
    } on Exception catch (e) {
      handleError(e);
    }
  }

  void _openNewWordScreen() {
    navigator.push(NewWordScreenRoute());
  }
}
