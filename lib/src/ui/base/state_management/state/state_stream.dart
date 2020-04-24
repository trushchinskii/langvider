import 'dart:async';

import 'package:langvider/src/ui/base/state_management/state/base/streamable.dart';

class StateStream<T> implements Streamable<T> {
  StateStream([this.initialData]) {
    if (initialData != null) accept(initialData);
  }

  final T initialData;

  final _stateStreamController = StreamController<T>.broadcast();

  @override
  Stream<T> get stream => _stateStreamController.stream;

  T _lastValue;

  T get value => _lastValue;

  void accept([T data]) {
    _lastValue = data;
    _stateStreamController.sink.add(data);
  }

  void notify() => accept(value);

  @override
  void close() {
    _stateStreamController.close();
  }
}
