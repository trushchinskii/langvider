import 'package:flutter/widgets.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class VisibleIfKeyboardHided extends StatefulWidget {
  VisibleIfKeyboardHided({this.child});

  final Widget child;

  @override
  _VisibleIfKeyboardHidedState createState() => _VisibleIfKeyboardHidedState();
}

class _VisibleIfKeyboardHidedState extends State<VisibleIfKeyboardHided> {
  bool _isKeyboardVisible = false;
  final _keyboardNotifier = KeyboardVisibilityNotification();

  @override
  void initState() {
    super.initState();

    _keyboardNotifier.addNewListener(
      onChange: (visible) {
        _isKeyboardVisible = visible;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _isKeyboardVisible ? 0 : 1,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _keyboardNotifier.dispose();
    super.dispose();
  }
}
