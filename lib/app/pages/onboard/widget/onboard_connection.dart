import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:dimipay_kiosk/app/pages/onboard/controller.dart';
import 'package:flutter/widgets.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'package:dimipay_kiosk/app/pages/onboard/widget/onboard_status.dart';

class OnboardConnection extends StatelessWidget {
  const OnboardConnection({super.key});

  @override
  Widget build(BuildContext context) => OnboardStatus(
      icon: OnboardPageController.to.isConnected
          ? Symbols.hourglass_rounded
          : Symbols.dns_rounded,
      title: OnboardPageController.to.isConnecting
          ? "서버 연결 중"
          : OnboardPageController.to.isConnected
              ? "서버 연결 완료"
              : "서버 연결 실패",
      color: OnboardPageController.to.isConnected
          ? DPColors.grayscale500
          : DPColors.primaryNegative);
}
