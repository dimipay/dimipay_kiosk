import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/pages/onboard/controller.dart';
import 'package:dimipay_kiosk/app/widgets/scanner_listener.dart';
import 'package:material_symbols_icons/symbols.dart';

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

class OnboardPage extends GetView<OnboardPageController> {
  const OnboardPage({super.key});

  @override
  Widget build(BuildContext context) => ScannerListener(
      onKey: (_) {
        Get.toNamed(Routes.PRODUCT);
      },
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
            child: Row(children: [
              Obx(() => OnboardStatus(
                  icon: OnboardPageController.to.kiosk.value == null
                      ? Symbols.hourglass_rounded
                      : Symbols.dns_rounded,
                  title: OnboardPageController.to.kiosk.value == null
                      ? "서버 연결 중"
                      : OnboardPageController.to.kiosk.value?.updatedAt != null
                          ? "서버 연결 완료"
                          : "서버 연결 실패",
                  color: OnboardPageController.to.kiosk.value == null
                      ? DPColors.primaryNegative
                      : DPColors.grayscale500)),
              const SizedBox(width: 16),
              Obx(() => OnboardPageController.to.kiosk.value != null
                  ? Row(children: [
                      const OnboardDivider(),
                      const SizedBox(width: 16),
                      OnboardStatus(
                          icon: Symbols.browse_activity_rounded,
                          title: OnboardPageController.to.kiosk.value!.name,
                          color: DPColors.grayscale500),
                      const SizedBox(width: 16),
                      const OnboardDivider(),
                      const SizedBox(width: 16),
                      const OnboardStatus(
                          icon: Symbols.school_rounded,
                          title: "한국디지털미디어고등학교",
                          color: DPColors.grayscale500)
                    ])
                  : const SizedBox(height: 0))
            ]))
      ])))));
}
