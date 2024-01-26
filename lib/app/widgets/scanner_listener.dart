import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScannerListener extends StatelessWidget {
  const ScannerListener({super.key, required this.child, required this.onKey});

  final Widget child;
  final Function(RawKeyDownEvent event) onKey;

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
        autofocus: true,
        focusNode: FocusNode(),
        onKey: (event) {
          if (event is RawKeyDownEvent) onKey(event);
        },
        child: child);
  }
}
