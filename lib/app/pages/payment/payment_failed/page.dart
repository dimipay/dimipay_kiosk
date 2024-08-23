import 'package:dimipay_kiosk/app/pages/payment/payment_failed/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentFailedPage extends GetView<PaymentFailedPageController> {
  const PaymentFailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Payment Page'),
      ),
    );
  }
}
