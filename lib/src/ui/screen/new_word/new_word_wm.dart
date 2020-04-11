import 'package:langvider/src/interactor/common/logger/logger.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/base/state_management/state/action.dart';
import 'package:langvider/src/ui/base/state_management/state/state_stream.dart';
import 'package:langvider/src/ui/base/state_management/state/text_state_stream.dart';

class NewWordScreenWm extends BaseWidgetModel {
  NewWordScreenWm(WmDependencies dependencies) : super(dependencies);

  final wordState = TextStream();
  final translationState = TextStream();
  final enableAddWordButtonState = StateStream<bool>(false);

  final addWordAction = Action();

  bool get _isWordNotEmpty => wordState.text?.isNotEmpty ?? false;
  bool get _isTranslationNotEmpty => translationState.text?.isNotEmpty ?? false;

  @override
  void initListeners() {
    listen(wordState, _handleInputWord);
    listen(translationState, _handleInputTranslation);
    listen(addWordAction, (_) => _addWord());
  }

  void _handleInputWord(String wordText) {
    _canAddWord();
  }

  void _handleInputTranslation(String translationText) {
    _canAddWord();
  }

  bool _canAddWord() {
    final bool isEnable = _isWordNotEmpty && _isTranslationNotEmpty;
    enableAddWordButtonState.accept(isEnable);

    return isEnable;
  }

  void _addWord() {
    log.d('Add word');
  }
}
