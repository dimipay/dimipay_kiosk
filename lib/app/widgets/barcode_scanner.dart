import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({
    super.key,
    required this.child,
    required this.onScan,
  });

  final Widget child;
  final ValueChanged<String> onScan;

  @override
  State<BarcodeScanner> createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner> {
  final FocusNode _focusNode = FocusNode();
  String _input = '';

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter && _input.isNotEmpty) {
        widget.onScan(_input);
        _input = '';
      } else if (event.character != null && event.character!.isNotEmpty) {
        _input += event.character!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: _handleKeyEvent,
      child: widget.child,
    );
  }
}
