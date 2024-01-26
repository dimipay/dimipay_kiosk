import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:dimipay_kiosk/app/pages/onboard/widget/onboard_device.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/pages/onboard/widget/onboard_connection.dart';
import 'package:dimipay_kiosk/app/pages/onboard/widget/onboard_divider.dart';
import 'package:dimipay_kiosk/app/pages/onboard/controller.dart';
import 'package:dimipay_kiosk/app/widgets/scanner_listener.dart';

class OnboardPage extends GetView<OnboardPageController> {
  const OnboardPage({super.key});

  @override
  Widget build(BuildContext context) => ScannerListener(
      onKey: (_) => OnboardPageController.to.isConnected
          ? Get.toNamed(Routes.PRODUCT)
          : (),
      child: Scaffold(
          body: SafeArea(
              child: SizedBox.expand(
                  child: Column(children: [
        Expanded(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset("assets/images/dimipay_logo.svg"),
            const SizedBox(width: 24),
            SvgPicture.asset("assets/images/dimipay_typography.svg")
          ]),
          const SizedBox(height: 64),
          Text("매점에 오신 것을 환영합니다!",
              style: DPTypography.title(color: DPColors.grayscale1000)),
          const SizedBox(height: 16),
          Text("물건의 바코드를 스캔하여 결제를 시작해주세요",
              style: DPTypography.header2(color: DPColors.grayscale700))
        ])),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            child: const Row(children: [
              OnboardConnection(),
              SizedBox(width: 16),
              OnboardDevice()

              // SizedBox(width: 16),
              // OnboardDivider(),
              // SizedBox(width: 16),
              // OnboardStatus(icon: Symbols.school_rounded, title: "한국디지털미디어고등학교")
            ]))
      ])))));
}
