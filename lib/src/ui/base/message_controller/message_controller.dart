import 'package:flutter/material.dart';

class MessageController {
  final GlobalKey<ScaffoldState> _scaffoldKey;

  MessageController(this._scaffoldKey);

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnack(
    String text,
  ) {
    return _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
