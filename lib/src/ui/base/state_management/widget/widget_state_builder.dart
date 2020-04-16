import 'package:flutter/widgets.dart';
import 'package:langvider/src/ui/base/state_management/state/loading_state_stream.dart';

typedef DataWidgetBuilder<T> = Widget Function(BuildContext, T data);
typedef ErrorWidgetBuilder = Widget Function(BuildContext, Exception error);
typedef LoadingWidgetBuilder = Widget Function(BuildContext);

class LoadingBuilder<T> extends StatelessWidget {
  const LoadingBuilder({
    @required this.state,
    @required this.builder,
    @required this.loadingBuilder,
    @required this.errorBuilder,
    Key key,
  })  : assert(state != null),
        assert(
          builder != null && loadingBuilder != null && errorBuilder != null,
        ),
        super(key: key);

  final LoadingStateStream<T> state;

  final DataWidgetBuilder<T> builder;
  final LoadingWidgetBuilder loadingBuilder;
  final ErrorWidgetBuilder errorBuilder;

  @override
  Widget build(BuildContext context) => StreamBuilder<LoadingState<T>>(
        stream: state.stream,
        initialData: state.initialData,
        builder: (context, snapshot) {
          final LoadingState<T> state = snapshot.data;

          if (state?.isLoading ?? false) {
            return _buildLoadingState(context);
          } else if (state?.hasError ?? false) {
            return _buildErrorState(snapshot, context);
          } else {
            return _buildContentState(context, state);
          }
        },
      );

  Widget _buildLoadingState(BuildContext context) => loadingBuilder(context);

  Widget _buildErrorState(
    AsyncSnapshot<LoadingState> snapshot,
    BuildContext context,
  ) {
    final Object errorCourse = snapshot.data?.error ?? snapshot.error;

    if (errorCourse is Exception) {
      return errorBuilder(context, errorCourse);
    } else {
      return errorBuilder(context, Exception(snapshot.error));
    }
  }

  Widget _buildContentState(
    BuildContext context,
    LoadingState<T> state,
  ) {
    return builder(context, state?.data);
  }
}
