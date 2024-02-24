import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Lottie.network(
                "https://assets4.lottiefiles.com/packages/lf20_pmYw5P.json")));
  }
}
