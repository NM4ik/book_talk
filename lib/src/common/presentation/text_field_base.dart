import 'package:book_talk/src/common/utils/disposable.dart';
import 'package:flutter/widgets.dart';

final class TextFieldController implements Disposable {
  TextFieldController()
    : controller = TextEditingController(),
      focusNode = FocusNode();

  final TextEditingController controller;
  final FocusNode focusNode;

  set text(String value) => controller.text = value;
  String get text => controller.text;

  Listenable get listenable => Listenable.merge([controller, focusNode]);

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
  }
}
