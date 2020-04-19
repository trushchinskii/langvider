import 'package:langvider/src/domain/word.dart';
import 'package:langvider/src/interactor/dictionary/dictionary_interactor.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/base/state_management/state/action.dart';
import 'package:langvider/src/ui/base/state_management/state/loading_state_stream.dart';
import 'package:langvider/src/ui/screen/new_word/new_word_screen_route.dart';
import 'package:pedantic/pedantic.dart';

class DictionaryScreenWm extends BaseWidgetModel {
  DictionaryScreenWm(
    WmDependencies dependencies,
    this._dictionaryInteractor,
  ) : super(dependencies);

  final DictionaryInteractor _dictionaryInteractor;

  final wordsState = LoadingStateStream<List<Word>>(LoadingState.content([]));

  final loadDataAction = Action();
  final deleteWordAction = Action<Word>();
  final openNewWordScreenAction = Action();

  @override
  void onAttached() {
    super.onAttached();

    _initListeners();
    _loadWords();
  }

  void _initListeners() {
    listen(deleteWordAction, _deleteWord);
    listen(openNewWordScreenAction, (_) => _openNewWordScreen());
    listen(loadDataAction, (_) => _loadWords());
  }

  Future<void> _loadWords({bool withLoader = true}) async {
    if (withLoader) wordsState.loading();

    try {
      final words = await _dictionaryInteractor.getWords();
      wordsState.content(words);
    } on Exception catch (e) {
      wordsState.error(e);
      handleError(e);
    }
  }

  void _deleteWord(Word word) {
    try {
      _dictionaryInteractor.deleteWord(word);
    } on Exception catch (e) {
      handleError(e);
    }

    _loadWords(withLoader: false);
  }

  Future<void> _openNewWordScreen() async {
    await navigator.push(NewWordScreenRoute());
    unawaited(_loadWords(withLoader: false));
  }
}
