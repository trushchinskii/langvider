import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/state_management/state/base/streamable.dart';
import 'package:langvider/src/ui/base/state_management/state/state_stream.dart';

class TextStream implements Streamable<String> {
  TextStream({
    String text,
  }) : controller = TextEditingController(text: text) {
    controller.addListener(() {
      _stateStream.accept(controller.text);
    });
  }

  final TextEditingController controller;

  final _stateStream = StateStream<String>();

  @override
  Stream<String> get stream => _stateStream.stream;

  String get text => controller?.text;

  @override
  void close() {
    controller.dispose();
    _stateStream.close();
  }
}
