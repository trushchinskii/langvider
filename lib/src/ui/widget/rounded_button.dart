import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  RoundedButton({
    @required this.title,
    this.onPressed,
  });

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
