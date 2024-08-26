import 'package:dimipay_design_kit/interfaces/dimipay_colors.dart';
import 'package:dimipay_design_kit/interfaces/dimipay_typography.dart';
import 'package:dimipay_kiosk/app/pages/payment/payment_failed/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPendingPage extends GetView<PaymentFailedPageController> {
  const PaymentPendingPage({super.key});

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
            Text("결제 중...",
                style:
                    textTheme.title.copyWith(color: colorTheme.grayscale1000)),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
