import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/widgets.dart';

class OnboardStatus extends StatelessWidget {
  const OnboardStatus(
      {super.key,
      required this.title,
      required this.icon,
      required this.color});

  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      DPIcons(icon, fill: 0, size: 20, color: color),
      const SizedBox(width: 6),
      Text(title, style: DPTypography.itemTitle(color: color))
    ]);
  }
}
