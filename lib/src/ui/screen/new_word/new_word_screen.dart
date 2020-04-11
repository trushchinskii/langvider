import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/screen/base_widget.dart';
import 'package:langvider/src/ui/base/state_management/widget/state_builder.dart';
import 'package:langvider/src/ui/screen/new_word/new_word_wm.dart';

class NewWordScreen extends BaseWidget {
  @override
  BaseWidgetState buildState() => _NewWordState();
}

class _NewWordState extends BaseWidgetState<NewWordScreen, NewWordScreenWm> {
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      key: wm.scaffoldKey,
      appBar: _buildAppBar(),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 24),
          _buildWord(),
          const SizedBox(height: 16),
          _buildTranslation(),
          Expanded(child: SizedBox()),
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

  // TODO add focuses
  Widget _buildWord() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: wm.wordState.controller,
        decoration: InputDecoration(
          labelText: str.newWordWordLabel,
          border: OutlineInputBorder(),
        ),
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
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      height: 42,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16),
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
    );
  }
}
