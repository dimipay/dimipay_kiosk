import 'package:dimipay_kiosk/app/pages/payment/payment_failed/controller.dart';
import 'package:dimipay_kiosk/app/pages/payment/payment_success/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentSuccessPage extends GetView<PaymentSuccessPageController> {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Payment Success Page'),
      ),
    );
  }
}
