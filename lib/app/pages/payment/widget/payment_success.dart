import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body:
                // Center(
                // child:

                Column(mainAxisSize: MainAxisSize.min, children: [
      Lottie.network(
          "https://assets4.lottiefiles.com/packages/lf20_pmYw5P.json",
          width: 420,
          height: 420),
      Text(
        "결제가 성공적으로 완료되었어요!",
        style: DPTypography.title(color: DPColors.grayscale1000),
      ),
    ]))
        // )
        ;
  }
}
