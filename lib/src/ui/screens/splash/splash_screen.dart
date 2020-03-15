import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langvider/src/ui/base/screen/base_widget.dart';
import 'package:langvider/src/ui/screens/splash/splash_wm.dart';
import 'package:langvider/src/ui/utils/colors.dart';

class SplashScreen extends BaseWidget {
  @override
  BaseWidgetState buildState() => _SplashState();
}

class _SplashState extends BaseWidgetState<SplashScreen, SplashScreenWm> {
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          str.splashScreenTitle,
          style: GoogleFonts.pacifico(
            fontWeight: FontWeight.w400,
            textStyle: TextStyle(
              fontSize: 48,
              color: secondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
