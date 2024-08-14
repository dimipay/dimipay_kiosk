// import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin Press {
  final RxString _pressedButton = "".obs;

  pressButton(String button) {
    _pressedButton.value = button;
  }

  resetButton() {
    _pressedButton.value = "";
  }

  bool isPressed(String button) {
    return _pressedButton.value == button;
  }

  String get pressedButton => _pressedButton.value;
}

// class PressProvider extends InheritedWidget {
//   final Press press;

//   const PressProvider({
//     super.key,
//     required super.child,
//     required this.press,
//   });

//   static PressProvider? of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<PressProvider>();
//   }

//   @override
//   bool updateShouldNotify(PressProvider oldWidget) {
//     return oldWidget.press != press;
//   }
// }

// class PressWidget extends StatelessWidget with Press {
//   final Widget child;

//   PressWidget({super.key, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return PressProvider(
//       press: this,
//       child: GestureDetector(
//         onTapDown: (_) {
//           if (isPressed("")) pressButton(key.toString());
//         },
//         onTapCancel: () {
//           resetButton();
//         },
//         onTapUp: (_) {
//           resetButton();
//         },
//         child: child,
//       ),
//     );
//   }
// }
