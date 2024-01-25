import 'package:flutter/cupertino.dart';

class PaymentBackground extends StatelessWidget {
  const PaymentBackground({super.key});

  @override
  Widget build(BuildContext context) {
    List colorScheme = [
      const Color(0xFFFF0000),
      const Color(0xFFFF0000),
      const Color(0xFF00FF38),
      const Color(0xFF00C2FF),
      const Color(0xFF00C2FF),
      const Color(0xFF4200FF),
      const Color(0xFFFF7A00),
    ];

    return Stack(
        children: colorScheme
            .map((e) => Center(
                    // left: 0,
                    // top: 0,
                    child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(250),
                    color: e,
                  ),
                )))
            .toList());
  }
}
