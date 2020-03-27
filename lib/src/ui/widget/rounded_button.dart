import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({
    @required this.title,
    this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        title,
      ),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
    );
  }
}
