import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:langvider/src/domain/word.dart';
import 'package:langvider/src/ui/base/screen/base_widget.dart';
import 'package:langvider/src/ui/base/state_management/widget/widget_stream_builder.dart';
import 'package:langvider/src/ui/screen/dictionary/dictionary_wm.dart';
import 'package:langvider/src/ui/utils/colors.dart';
import 'package:langvider/src/ui/utils/text_styles.dart';

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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: wm.openNewWordScreenAction,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return WidgetStreamBuilder<List<Word>>(
      stream: wm.wordsStream,
      initialData: const [],
      builder: (_, words) {
        if (words.isEmpty) {
          return _buildEmptyState();
        } else {
          return _buildWords(words);
        }
      },
      loadingBuilder: _buildLoadingState,
      errorBuilder: _buildErrorState,
    );
  }

  Widget _buildWords(List<Word> words) => ListView.builder(
        itemCount: words.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: Slidable(
              actionPane: const SlidableBehindActionPane(),
              actionExtentRatio: 0.25,
              child: _buildWord(words[index]),
              secondaryActions: [_buildDeleteAction(words[index])],
            ),
          );
        },
      );

  Widget _buildWord(Word word) {
    return Card(
      color: reefColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        height: 64,
        width: double.infinity,
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
    );
  }

  Widget _buildLoadingState(context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorState(context, Exception exception) {
    return Center(
      child: Text(
        str.dictionaryErrorText,
        style: errorTextStyle,
      ),
    );
  }

  Widget _buildDeleteAction(Word word) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconSlideAction(
          color: burntSiennaColor,
          icon: Icons.delete,
          onTap: () => wm.deleteWordAction(word),
        ),
      );

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        str.dictionaryEmptyText,
        textAlign: TextAlign.center,
      ),
    );
  }
}
