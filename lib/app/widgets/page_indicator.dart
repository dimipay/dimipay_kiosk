import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      alignment: WrapAlignment.center,
      children: [
        for (int i = 0; i < 4; i++)
          Container(
            height: 28,
            width: 28,
            decoration: BoxDecoration(
              color: DPColors.grayscale800,
              borderRadius: BorderRadius.circular(14),
            ),
          ),
      ],
    );
  }
}
