import 'package:dimipay_kiosk/app/pages/payment/payment_failed/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPendingPage extends GetView<PaymentFailedPageController> {
  const PaymentPendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Payment Pending Page'),
      ),
    );
  }
}
