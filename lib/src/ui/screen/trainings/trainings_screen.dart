import 'package:flutter/material.dart';
import 'package:langvider/src/domain/training_type.dart';
import 'package:langvider/src/ui/base/screen/base_widget.dart';
import 'package:langvider/src/ui/base/state_management/widget/loading_builder.dart';
import 'package:langvider/src/ui/screen/trainings/trainings_wm.dart';

class TrainingsScreen extends BaseWidget {
  @override
  BaseWidgetState buildState() => _TrainingsState();
}

class _TrainingsState
    extends BaseWidgetState<TrainingsScreen, TrainingsScreenWm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: wm.scaffoldKey,
      body: _buildBody(),
    );
  }

  Widget _buildBody() => LoadingBuilder<bool>(
        state: wm.trainingEnablingState,
        builder: (context, isTrainingEnable) => isTrainingEnable
            ? ListView(
                children: <Widget>[
                  const SizedBox(height: 24),
                  _TrainingsListTile(
                    title: str.trainingsSelectTextTranslationText,
                    onPressed: () => wm.openSelectingTrainingAction(
                      TrainingType.selectTextTranslation,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _TrainingsListTile(
                    title: str.trainingsSelectTranslationTextText,
                    onPressed: () => wm.openSelectingTrainingAction(
                      TrainingType.selectTranslationText,
                    ),
                  ),
                  // const SizedBox(height: 16),
                  // _TrainingsListTile(
                  //   title: str.trainingsWriteTextTranslationText,
                  //   onPressed: () => wm.openWritingTrainingAction(
                  //     TrainingScreenType.textTranslation,
                  //   ),
                  // ),
                  // const SizedBox(height: 16),
                  // _TrainingsListTile(
                  //   title: str.trainingsWriteTranslationTextText,
                  //   onPressed: () => wm.openWritingTrainingAction(
                  //     TrainingScreenType.translationText,
                  //   ),
                  // ),
                ],
              )
            : _buildEmptyState(),
        loadingBuilder: _buildLoadingState,
        errorBuilder: _buildErrorState,
      );

  Widget _buildEmptyState() => Center(child: Text(str.trainingsEmptyStateText));

  Widget _buildLoadingState(context) => const Center(
        child: CircularProgressIndicator(),
      );

  Widget _buildErrorState(context, Exception e) => Column(
        children: [
          Text(str.trainingsErrorText),
          const SizedBox(height: 16),
          RaisedButton(
            child: Text(str.repeat),
            onPressed: wm.reloadData,
          )
        ],
      );
}

class _TrainingsListTile extends StatelessWidget {
  _TrainingsListTile({
    @required this.title,
    @required this.onPressed,
  }) : assert(title != null && onPressed != null);

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Container(
        height: 84,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: RaisedButton(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
            ),
          ),
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          color: Colors.green,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          onPressed: onPressed,
        ),
      );
}
