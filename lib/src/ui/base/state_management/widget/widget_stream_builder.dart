import 'package:flutter/widgets.dart';
import 'package:langvider/src/interactor/common/logger/logger.dart';

typedef DataWidgetBuilder<T> = Widget Function(BuildContext, T data);
typedef ErrorWidgetBuilder = Widget Function(BuildContext, Exception error);
typedef LoadingWidgetBuilder = Widget Function(BuildContext);

class WidgetStreamBuilder<T> extends StatelessWidget {
  const WidgetStreamBuilder({
    @required this.stream,
    @required this.builder,
    @required this.loadingBuilder,
    @required this.errorBuilder,
    Key key,
    this.initialData,
  })  : assert(stream != null),
        assert(
          builder != null && loadingBuilder != null && errorBuilder != null,
        ),
        super(key: key);

  final Stream<T> stream;

  final DataWidgetBuilder<T> builder;
  final LoadingWidgetBuilder loadingBuilder;
  final ErrorWidgetBuilder errorBuilder;
  final T initialData;

  @override
  Widget build(BuildContext context) => StreamBuilder<T>(
        stream: stream,
        initialData: initialData,
        builder: (context, snapshot) {
          log.i('${snapshot.connectionState} hasData=${snapshot.hasData}');

          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingState(context);
          } else if (snapshot.hasError) {
            return _buildErrorState(snapshot, context);
          } else {
            return _buildContentState(context, snapshot.data);
          }
        },
      );

  Widget _buildLoadingState(BuildContext context) => loadingBuilder(context);

  Widget _buildErrorState(
    AsyncSnapshot<T> snapshot,
    BuildContext context,
  ) {
    final Object errorCourse = snapshot.error;

    if (errorCourse is Exception) {
      return errorBuilder(context, errorCourse);
    } else {
      return errorBuilder(context, Exception(snapshot.error));
    }
  }

  Widget _buildContentState(
    BuildContext context,
    T data,
  ) {
    return builder(context, data);
  }
}
