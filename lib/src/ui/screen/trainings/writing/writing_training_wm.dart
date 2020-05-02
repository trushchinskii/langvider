import 'package:langvider/src/domain/training_type.dart';
import 'package:langvider/src/ui/base/screen/base_widget_model.dart';

class WritingTrainingScreenWm extends BaseWidgetModel {
  WritingTrainingScreenWm(
    WmDependencies dependencies,
    this.screenType,
  ) : super(dependencies);

  final TrainingType screenType;
}
