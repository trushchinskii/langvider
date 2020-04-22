import 'package:langvider/src/ui/base/screen/base_widget_model.dart';
import 'package:langvider/src/ui/screen/trainings/training_screen_type.dart';

class WritingTrainingScreenWm extends BaseWidgetModel {
  WritingTrainingScreenWm(
    WmDependencies dependencies,
    this.screenType,
  ) : super(dependencies);

  final TrainingScreenType screenType;
}
