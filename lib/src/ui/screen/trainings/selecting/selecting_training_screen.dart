import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/screen/base_widget.dart';
import 'package:langvider/src/ui/base/state_management/widget/loading_builder.dart';
import 'package:langvider/src/ui/screen/trainings/selecting/selecting_training_wm.dart';
import 'package:langvider/src/ui/screen/trainings/training_screen_type.dart';
import 'package:langvider/src/ui/utils/text_styles.dart';

class SelectingTrainingScreen extends BaseWidget {
  SelectingTrainingScreen({this.screenType});

  final TrainingScreenType screenType;

  @override
  BaseWidgetState buildState() => _SelectingTrainingState();
}

class _SelectingTrainingState extends BaseWidgetState<SelectingTrainingScreen,
    SelectingTrainingScreenWm> {
  @override
  Widget build(BuildContext context) => Scaffold(
        key: wm.scaffoldKey,
        body: _buildBody(),
      );

  Widget _buildBody() => LoadingBuilder<SelectingTrainingData>(
        state: wm.trainingState,
        builder: _buildTraining,
        loadingBuilder: _buildLoadState,
        errorBuilder: _buildErrorState,
      );

  Widget _buildLoadState(context) => const Center(
        child: CircularProgressIndicator(),
      );

  Widget _buildErrorState(context, Exception e) => Center(
        child: Text(e.toString()),
      );

  Widget _buildTraining(context, SelectingTrainingData trainingData) =>
      trainingData.type == SelectingTrainingDataType.word
          ? Column(
              children: [
                Expanded(child: _buildTrainingWord(trainingData)),
                _buildAnswers(trainingData),
              ],
            )
          : _buildCompleteWidget();

  Widget _buildTrainingWord(SelectingTrainingData trainingData) => Center(
        child: Text(
          widget.screenType == TrainingScreenType.textTranslation
              ? trainingData.word.text
              : trainingData.word.translation,
          style: h5,
        ),
      );

  Widget _buildAnswers(SelectingTrainingData trainingData) => Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const SizedBox(width: 16),
              Expanded(child: _buildAnswer(trainingData.answers[0])),
              const SizedBox(width: 16),
              Expanded(child: _buildAnswer(trainingData.answers[1])),
              const SizedBox(width: 16),
            ],
          ),
          if (trainingData.answers.length > 2)
            Row(
              children: <Widget>[
                const SizedBox(width: 16),
                Expanded(child: _buildAnswer(trainingData.answers[2])),
                const SizedBox(width: 16),
                Expanded(
                  child: trainingData.answers.length > 3
                      ? _buildAnswer(trainingData.answers[3])
                      : const SizedBox.shrink(),
                ),
                const SizedBox(width: 16),
              ],
            ),
          const SizedBox(height: 24),
        ],
      );

  Widget _buildAnswer(SelectingAnswer answer) => RaisedButton(
        color: _getAnswerColor(answer.isCorrect),
        child: Text(
          widget.screenType == TrainingScreenType.textTranslation
              ? answer.word.translation
              : answer.word.text,
          style: h5,
        ),
        onPressed: () => wm.answerAction(answer),
      );

  Color _getAnswerColor(bool isCorrect) {
    if (isCorrect == null) return Colors.grey;

    if (isCorrect) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  Widget _buildCompleteWidget() => Center(
        child: RaisedButton(
          child: Text(str.trainingsSelectCompleteText),
          onPressed: wm.completeAction,
        ),
      );
}
