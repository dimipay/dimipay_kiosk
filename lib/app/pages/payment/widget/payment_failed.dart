import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PaymentFailed extends StatelessWidget {
  const PaymentFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Lottie.network(
                "https://assets7.lottiefiles.com/packages/lf20_s0fkqiqh.json")));
  }
}
