import 'dart:async';

import 'package:langvider/src/ui/base/state_management/state/base/streamable.dart';

class Action<T> implements Streamable<T> {
  final _actionStreamController = StreamController<T>.broadcast();

  @override
  Stream<T> get stream => _actionStreamController.stream;

  T _lastValue;

  T get value => _lastValue;

  void accept([T data]) {
    _lastValue = data;
    _actionStreamController.sink.add(data);
  }

  void call([T data]) => accept(data);

  @override
  void close() {
    _actionStreamController.close();
  }
}
