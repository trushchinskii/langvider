import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/screen/base_widget.dart';
import 'package:langvider/src/ui/base/state_management/widget/state_builder.dart';
import 'package:langvider/src/ui/screen/new_word/new_word_wm.dart';
import 'package:langvider/src/ui/utils/focus_navigator.dart';
import 'package:langvider/src/ui/widget/visible_if_keyboard_hided.dart';

class NewWordScreen extends BaseWidget {
  @override
  BaseWidgetState buildState() => _NewWordState();
}

class _NewWordState extends BaseWidgetState<NewWordScreen, NewWordScreenWm> {
  _NewWordState() {
    _focusManager = FocusNavigator([
      _wordFocus,
      _translationFocus,
    ]);
  }

  final _wordFocus = FocusNode();
  final _translationFocus = FocusNode();

  FocusNavigator _focusManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: wm.scaffoldKey,
      appBar: _buildAppBar(),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 24),
          _buildWord(),
          const SizedBox(height: 16),
          _buildTranslation(),
          const Expanded(child: SizedBox()),
          _buildButton(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(str.newWordAppBarTitle),
    );
  }

  Widget _buildWord() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: wm.wordState.controller,
        decoration: InputDecoration(
          labelText: str.newWordWordLabel,
          border: const OutlineInputBorder(),
        ),
        autofocus: true,
        focusNode: _wordFocus,
        textInputAction: TextInputAction.next,
        onSubmitted: (_) => _focusManager.next(),
      ),
    );
  }

  Widget _buildTranslation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: wm.translationState.controller,
        decoration: InputDecoration(
          labelText: str.newWordTranslationLabel,
          border: const OutlineInputBorder(),
        ),
        focusNode: _translationFocus,
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => _focusManager.next(),
      ),
    );
  }

  Widget _buildButton() {
    return VisibleIfKeyboardHided(
      child: Container(
        height: 42,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: StateBuilder<bool>(
          state: wm.enableAddWordButtonState,
          builder: (context, isEnable) => RaisedButton(
            child: Text(str.newWordButtonText),
            onPressed: isEnable ? wm.addWordAction : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _wordFocus.dispose();
    _translationFocus.dispose();

    super.dispose();
  }
}
