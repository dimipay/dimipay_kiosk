import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dimipay_kiosk/app/services/product/service.dart';

class ScannerListener extends StatelessWidget {
  const ScannerListener({super.key, required this.child, required this.onKey});

  final Widget child;
  final Function(RawKeyDownEvent event) onKey;
  static String _input = "";

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (event) {
        if (event is RawKeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.enter) {
            print(_input);
            ProductService.to.addProduct(_input);
            _input = "";
          } else if (RegExp(r'[a-zA-Z0-9]')
              .hasMatch(event.logicalKey.keyLabel)) {
            _input += event.logicalKey.keyLabel;
          }
        }
      },
      child: child,
    );
  }
}
