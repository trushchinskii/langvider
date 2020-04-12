import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/state_management/state/state_stream.dart';

class StateBuilder<T> extends StatelessWidget {
  const StateBuilder({
    @required this.state,
    @required this.builder,
    Key key,
  })  : assert(state != null && builder != null),
        super(key: key);

  final StateStream<T> state;

  final Widget Function(BuildContext, T) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      builder: (context, snapshot) => builder(context, snapshot.data),
      stream: state.stream,
      initialData: state.initialData,
    );
  }
}
