import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:dimipay_kiosk/app/pages/onboard/controller.dart';
import 'package:dimipay_kiosk/app/pages/onboard/widget/onboard_divider.dart';
import 'package:dimipay_kiosk/app/pages/onboard/widget/onboard_status.dart';
import 'package:flutter/widgets.dart';
import 'package:material_symbols_icons/symbols.dart';

class OnboardDevice extends StatelessWidget {
  const OnboardDevice({super.key});

  @override
  Widget build(BuildContext context) => OnboardPageController.to.isConnected
      ? Row(
          children: [
            OnboardDivider(),
            SizedBox(width: 16),
            OnboardStatus(
                icon: Symbols.browse_activity_rounded,
                title: "초록색 아이패드",
                color: DPColors.grayscale500),
          ],
        )
      : Container();
}
