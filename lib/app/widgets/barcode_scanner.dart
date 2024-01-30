import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarcodeScanner extends StatelessWidget {
  const BarcodeScanner({super.key, required this.child, required this.onKey});

  final Widget child;
  final Function(String input) onKey;
  static String _input = "";

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
        autofocus: true,
        focusNode: FocusNode(),
        onKey: (event) {
          if (event is RawKeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.enter && _input != "") {
              onKey(_input);
              _input = "";
            } else if (event.logicalKey.keyLabel.length == 1) {
              _input += event.logicalKey.keyLabel;
            }
          }
        },
        child: child);
  }
}
