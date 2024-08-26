import 'package:dimipay_design_kit/interfaces/dimipay_colors.dart';
import 'package:dimipay_design_kit/interfaces/dimipay_typography.dart';
import 'package:dimipay_kiosk/app/pages/payment/payment_success/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PaymentSuccessPage extends GetView<PaymentSuccessPageController> {
  const PaymentSuccessPage({super.key});

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
                "https://assets4.lottiefiles.com/packages/lf20_pmYw5P.json",
                width: 420,
                height: 420,
                fit: BoxFit.fitHeight,
                repeat: false),
            Text("결제가 성공적으로 완료되었어요!",
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
