import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({super.key, required this.child, required this.onKey});

  final Widget child;
  final Function(String input) onKey;

  @override
  _BarcodeScannerState createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner> {
  String _input = "";

  @override
  void initState() {
    super.initState();
    RawKeyboard.instance.addListener(_handleKeyEvent);
  }

  @override
  void dispose() {
    RawKeyboard.instance.removeListener(_handleKeyEvent);
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter && _input.isNotEmpty) {
        widget.onKey(_input);
        _input = "";
      } else if (event.character != null && event.character!.isNotEmpty) {
        _input += event.character!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}