import 'package:flutter/material.dart';
import 'package:langvider/src/ui/utils/colors.dart';

class MessageController {
  MessageController(this._scaffoldKey);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  BuildContext get _context => _scaffoldKey.currentContext;

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnack(
    String text, {
    MessageType type = MessageType.common,
  }) {
    return _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: _getBackgroundColor(type),
      ),
    );
  }

  Color _getBackgroundColor(MessageType type) {
    switch (type) {
      case MessageType.info:
        return secondaryColor;
      case MessageType.success:
        return Colors.greenAccent;
      case MessageType.error:
        return Colors.redAccent;
      default:
        return Theme.of(_context).snackBarTheme.backgroundColor;
    }
  }
}

enum MessageType {
  common,
  info,
  success,
  error,
}
