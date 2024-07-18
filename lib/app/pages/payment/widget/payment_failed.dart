import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/pages/payment/controller.dart';

class PaymentFailed extends GetView<PaymentPageController> {
  const PaymentFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 292),
          Lottie.network(
            "https://assets7.lottiefiles.com/packages/lf20_s0fkqiqh.json",
            width: 420,
            height: 420,
          ),
          const SizedBox(height: 16),
          Text(
            "결제에 실패했어요!",
            style: DPTypography.title(color: DPColors.primaryNegative),
          ),
          const SizedBox(height: 16),
          Text(
            "등록된 결제 수단을 다시 한 번 확인해주세요.",
            style: DPTypography.header1(color: DPColors.grayscale500),
          ),
          const SizedBox(height: 72),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => DPIcons(
                  Symbols.arrow_back_ios_new,
                  size: 24,
                  color: PaymentPageController.to.pressedButton == "failed_back"
                      ? DPColors.grayscale900
                      : DPColors.grayscale700,
                ),
              ),
              const SizedBox(width: 24),
              Obx(
                () => GestureDetector(
                  onTapDown: (_) =>
                      PaymentPageController.to.pressedButton = "failed_back",
                  onTapCancel: () =>
                      PaymentPageController.to.pressedButton = "",
                  onTapUp: (_) {
                    PaymentPageController.to.pressedButton = "";
                    Get.back();
                    Get.back();
                  },
                  child: Text(
                    "상품 스캔 화면으로 돌아가기",
                    style: DPTypography.header2(
                      color: PaymentPageController.to.pressedButton ==
                              "failed_back"
                          ? DPColors.grayscale900
                          : DPColors.grayscale700,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
