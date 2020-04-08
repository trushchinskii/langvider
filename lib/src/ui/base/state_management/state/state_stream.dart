import 'dart:async';

import 'package:langvider/src/ui/base/state_management/state/base/streamable.dart';

class StateStream<T> implements Streamable<T> {
  StateStream([T initialData]) {
    if (initialData != null) accept(initialData);
  }

  final _stateStreamController = StreamController<T>();

  @override
  Stream<T> get stream => _stateStreamController.stream;

  T _lastValue;

  T get value => _lastValue;

  void accept([T data]) {
    _stateStreamController.sink.add(data);
  }

  @override
  void close() {
    _stateStreamController.close();
  }
}
