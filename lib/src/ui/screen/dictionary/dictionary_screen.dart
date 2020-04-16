import 'package:flutter/material.dart';
import 'package:langvider/src/domain/word.dart';
import 'package:langvider/src/ui/base/screen/base_widget.dart';
import 'package:langvider/src/ui/base/state_management/widget/widget_state_builder.dart';
import 'package:langvider/src/ui/screen/dictionary/dictionary_wm.dart';
import 'package:langvider/src/ui/utils/colors.dart';

class DictionaryScreen extends BaseWidget {
  @override
  BaseWidgetState buildState() => _DictionaryState();
}

class _DictionaryState
    extends BaseWidgetState<DictionaryScreen, DictionaryScreenWm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: wm.scaffoldKey,
      appBar: AppBar(
        title: Text(str.dictionaryAppBarTitle),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return LoadingBuilder<List<Word>>(
      state: wm.wordsState,
      builder: _buildWords,
      loadingBuilder: _buildLoadingState,
      errorBuilder: _buildErrorState,
    );
  }

  Widget _buildWords(context, List<Word> words) {
    return ListView.builder(
      itemCount: words.length,
      itemBuilder: (_, index) {
        return _buildWord(words[index]);
      },
    );
  }

  Widget _buildWord(Word word) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Card(
        color: reefColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(word.text),
              const Expanded(child: SizedBox()),
              Text(word.translation),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState(context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorState(context, Exception exception) {
    return Center(
      child: Text(exception.toString()),
    );
  }
}
