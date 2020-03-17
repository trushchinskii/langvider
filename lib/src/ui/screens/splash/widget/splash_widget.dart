import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langvider/src/ui/utils/colors.dart';

class SplashWidget extends StatelessWidget {
  final String title;

  SplashWidget(this.title);

  @override
  Widget build(BuildContext context) => Text(
        title,
        style: GoogleFonts.pacifico(
          fontWeight: FontWeight.w400,
          textStyle: TextStyle(
            fontSize: 48,
            color: secondaryColor,
          ),
          shadows: [
            Shadow(
              blurRadius: 2,
              color: Colors.blue.withOpacity(0.14),
              offset: Offset(0, 0),
            ),
            Shadow(
              blurRadius: 2,
              color: Colors.blue.withOpacity(0.12),
              offset: Offset(0, 2),
            ),
            Shadow(
              blurRadius: 3,
              color: Colors.blue.withOpacity(0.2),
              offset: Offset(0, 1),
            ),
          ],
        ),
      );
}
