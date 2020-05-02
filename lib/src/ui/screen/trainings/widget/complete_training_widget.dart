import 'package:flutter/material.dart';
import 'package:langvider/src/ui/localozation/str/str.dart';

class CompleteTrainingWidget extends StatelessWidget {
  CompleteTrainingWidget({
    @required this.onPressed,
  }) : assert(onPressed != null);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text(Str.of(context).trainingsSelectCompleteText),
        onPressed: onPressed,
      ),
    );
  }
}
