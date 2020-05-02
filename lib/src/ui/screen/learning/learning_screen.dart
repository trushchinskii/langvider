import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/screen/base_widget.dart';
import 'package:langvider/src/ui/base/state_management/widget/loading_builder.dart';
import 'package:langvider/src/ui/screen/learning/learning_wm.dart';
import 'package:langvider/src/ui/screen/trainings/model/training_ui_data.dart';
import 'package:langvider/src/ui/screen/trainings/widget/complete_training_widget.dart';
import 'package:langvider/src/ui/screen/trainings/widget/selection_training_widget.dart';

class LearningScreen extends BaseWidget {
  @override
  BaseWidgetState buildState() => _LearningState();
}

class _LearningState extends BaseWidgetState<LearningScreen, LearningScreenWm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: wm.scaffoldKey,
      body: _buildBody(),
    );
  }

  Widget _buildBody() => LoadingBuilder<TrainingUiDataItem>(
        state: wm.uiDataItemState,
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

  Widget _buildTraining(context, TrainingUiDataItem trainingData) {
    switch (trainingData.status) {
      case TrainingUiDataItemStatus.inProgress:
        return SelectionTrainingWidget(
          data: trainingData,
          onAnswerTap: wm.answerAction,
        );
      case TrainingUiDataItemStatus.complete:
        return CompleteTrainingWidget(onPressed: wm.completeAction);
    }

    throw Exception('Unknown training data status ${trainingData.status}');
  }
}
