import 'package:dimipay_design_kit/interfaces/dimipay_colors.dart';
import 'package:dimipay_design_kit/interfaces/dimipay_typography.dart';
import 'package:dimipay_kiosk/app/pages/payment/payment_failed/controller.dart';
import 'package:dimipay_kiosk/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PaymentFailedPage extends GetView<PaymentFailedPageController> {
  const PaymentFailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<DPColors>()!;
    final textTheme = Theme.of(context).extension<DPTypography>()!;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(
              flex: 2,
            ),
            Lottie.network(
                "https://assets7.lottiefiles.com/packages/lf20_s0fkqiqh.json",
                width: 420,
                height: 420,
                fit: BoxFit.fitHeight,
                repeat: false),
            Text("결제에 실패했어요!",
                style: textTheme.title
                    .copyWith(color: colorTheme.primaryNegative)),
            const SizedBox(
              height: 16,
            ),
            Text("등록된 결제 수단을 다시 한 번 확인해주세요.",
                style:
                    textTheme.header1.copyWith(color: colorTheme.grayscale500)),
            const SizedBox(
              height: 72,
            ),
            DPGestureDetectorWithOpacityInteraction(
              onTap: () => Get.back(closeOverlays: true),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back_ios_new_rounded,
                      size: 24, color: colorTheme.grayscale600),
                  const SizedBox(width: 24),
                  Text(
                    '상품 스캔 화면으로 돌아가기',
                    style: textTheme.header1
                        .copyWith(color: colorTheme.grayscale1000),
                  ),
                ],
              ),
            ),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
