import 'package:flutter/material.dart';
import 'package:langvider/src/domain/training_type.dart';
import 'package:langvider/src/domain/word.dart';
import 'package:langvider/src/ui/screen/trainings/model/training_ui_data.dart';
import 'package:langvider/src/ui/utils/text_styles.dart';

class SelectionTrainingWidget extends StatelessWidget {
  SelectionTrainingWidget({
    @required this.data,
    @required this.onAnswerTap,
  }) : assert(data != null);

  final TrainingUiDataItem data;
  final ValueSetter<Word> onAnswerTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _buildTrainingWord(data)),
        _buildAnswers(data),
      ],
    );
  }

  Widget _buildTrainingWord(TrainingUiDataItem data) => Center(
        child: Text(
          data.trainingType == TrainingType.selectTextTranslation
              ? data.data.word.text
              : data.data.word.translation,
          style: h5,
        ),
      );

  Widget _buildAnswers(TrainingUiDataItem data) => Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const SizedBox(width: 16),
              Expanded(
                child: _buildAnswer(
                  type: data.trainingType,
                  answer: data.data.answers[0],
                  isAnswerCorrect: data.isAnswerCorrect,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildAnswer(
                  type: data.trainingType,
                  answer: data.data.answers[1],
                  isAnswerCorrect: data.isAnswerCorrect,
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          if (data.data.answers.length > 2)
            Row(
              children: <Widget>[
                const SizedBox(width: 16),
                Expanded(
                  child: _buildAnswer(
                    type: data.trainingType,
                    answer: data.data.answers[2],
                    isAnswerCorrect: data.isAnswerCorrect,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: data.data.answers.length > 3
                      ? _buildAnswer(
                          type: data.trainingType,
                          answer: data.data.answers[3],
                          isAnswerCorrect: data.isAnswerCorrect,
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(width: 16),
              ],
            ),
          const SizedBox(height: 24),
        ],
      );

  Widget _buildAnswer({
    @required TrainingType type,
    @required Word answer,
    @required bool isAnswerCorrect,
  }) =>
      RaisedButton(
        color: _getAnswerColor(isAnswerCorrect),
        child: Text(
          type == TrainingType.selectTextTranslation
              ? answer.translation
              : answer.text,
          style: h5,
        ),
        onPressed: () => onAnswerTap(answer),
      );

  Color _getAnswerColor(bool isCorrect) {
    if (isCorrect == null) return Colors.grey;

    if (isCorrect) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
}
