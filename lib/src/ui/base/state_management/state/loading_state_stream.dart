import 'package:langvider/src/ui/base/state_management/state/state_stream.dart';

class LoadingStateStream<T> extends StateStream<LoadingState<T>> {
  LoadingStateStream([LoadingState<T> initialData]) : super(initialData);

  void content([T data]) {
    final newState = LoadingState<T>.content(data);
    super.accept(newState);
  }

  void error([Exception error]) {
    final newState = LoadingState<T>.error(error);
    super.accept(newState);
  }

  void loading() {
    final newState = LoadingState<T>.loading();
    super.accept(newState);
  }
}

class LoadingState<T> {
  LoadingState({
    this.data,
    this.isLoading = false,
    this.error,
  });

  LoadingState.loading()
      : isLoading = true,
        error = null,
        data = null;

  LoadingState.error([this.error])
      : isLoading = false,
        data = null;

  LoadingState.content([this.data])
      : isLoading = false,
        error = null;

  final T data;
  final bool isLoading;
  final Exception error;

  bool get hasError => error != null;
}
