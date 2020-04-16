import 'package:langvider/src/domain/word.dart';
import 'package:langvider/src/interactor/dictionary/dictionary_interactor.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/base/state_management/state/loading_state_stream.dart';

class DictionaryScreenWm extends BaseWidgetModel {
  DictionaryScreenWm(
    WmDependencies dependencies,
    this._dictionaryInteractor,
  ) : super(dependencies);

  final DictionaryInteractor _dictionaryInteractor;

  final wordsState = LoadingStateStream<List<Word>>(LoadingState.content([]));

  @override
  void onAttached() {
    super.onAttached();

    _loadingWords();
  }

  Future<void> _loadingWords() async {
    wordsState.loading();
    final words = await _dictionaryInteractor.getWords();
    wordsState.content(words);
  }
}
