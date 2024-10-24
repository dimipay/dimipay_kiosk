import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarcodeScanner extends StatelessWidget {
  const BarcodeScanner({super.key, required this.child, required this.onKey});

  final Widget child;
  final Function(String input) onKey;
  static String _input = "";

  @override
  Widget build(BuildContext context) => KeyboardListener(
    autofocus: true,
    focusNode: FocusNode(),
    onKeyEvent: (event) {
      if (event is KeyDownEvent) {
        if (event.logicalKey == LogicalKeyboardKey.enter && _input != "") {
          onKey(_input);
          _input = "";
        } else if (event.character != null && event.character!.isNotEmpty) {
          _input += event.character!;
        }
      }
    },
    child: child,
  );
}