import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/pages/payment/controller.dart';

class BackgroundSpot extends StatelessWidget {
  const BackgroundSpot({super.key, required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size * 1.01,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(blurRadius: 400, color: color.withOpacity(0.7))],
      ),
    );
  }
}

class PaymentPage extends GetView<PaymentPageController> {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "디미페이 앱의 결제 QR를 스캔해주세요",
                    style: DPTypography.title(color: DPColors.grayscale1000),
                  ),
                  const SizedBox(height: 48),
                  Text(
                    "상품 스캔 창에서 결제 QR를 바로 스캔하면\n빠르게 결제를 완료할 수 있습니다",
                    textAlign: TextAlign.center,
                    style: DPTypography.header2(color: DPColors.grayscale600),
                  ),
                  const SizedBox(height: 64),
                  Container(
                    width: 420,
                    height: 8,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: DPColors.grayscale600.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Obx(
                      () => AnimatedContainer(
                        width:
                            420.0 - 14 * (30 - PaymentPageController.to.timer),
                        height: 8,
                        duration: const Duration(seconds: 1),
                        decoration: BoxDecoration(
                          color: DPColors.grayscale900.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => Text(
                      "${PaymentPageController.to.timer}초",
                      style: DPTypography.header2(color: DPColors.grayscale600),
                    ),
                  ),
                  const SizedBox(height: 132),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => Get.back(),
                    onTapDown: (_) =>
                        PaymentPageController.to.pressedButton = "back",
                    onTapCancel: () =>
                        PaymentPageController.to.pressedButton = "",
                    onTapUp: (_) => () {
                      print("back");
                      PaymentPageController.to.pressedButton = "";
                      Get.back();
                    },
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DPIcons(
                            Symbols.arrow_back_ios_new,
                            size: 24,
                            color:
                                PaymentPageController.to.pressedButton == "back"
                                    ? DPColors.grayscale600.withOpacity(0.5)
                                    : DPColors.grayscale600,
                          ),
                          const SizedBox(width: 24),
                          Text(
                            "상품 스캔 화면으로 돌아가기",
                            style: DPTypography.header2(
                              color: PaymentPageController.to.pressedButton ==
                                      "back"
                                  ? DPColors.grayscale600.withOpacity(0.5)
                                  : DPColors.grayscale600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => AnimatedRotation(
                turns: PaymentPageController.to.turns,
                duration: const Duration(milliseconds: 5000),
                curve: Curves.easeInQuad,
                child: Stack(
                  children: [
                    ...PaymentPageController.to.backgroundSpot.map((spot) {
                      return AnimatedPositioned(
                        left: spot.left.value,
                        top: spot.top.value,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOutCubic,
                        child: BackgroundSpot(
                            size: spot.size, color: Color(spot.color)),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
