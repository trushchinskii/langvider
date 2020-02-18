import 'package:flutter/material.dart';
import 'package:langvider/src/ui/app/app.dart';
import 'package:langvider/src/ui/app/app_provider.dart';

void main() => runApp(
      AppProvider(
        child: App(),
      ),
    );
