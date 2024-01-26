import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/widgets.dart';

class OnboardDivider extends StatelessWidget {
  const OnboardDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 4,
        height: 4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: DPColors.grayscale500));
  }
}
