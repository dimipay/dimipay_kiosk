import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:dimipay_kiosk/app/pages/payment/widget/payment_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';

import 'package:dimipay_kiosk/app/pages/payment/controller.dart';

class PaymentPage extends GetView<PaymentPageController> {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SizedBox.expand(
                child: Stack(alignment: Alignment.center, children: [
      const PaymentBackground(),
      ClipRect(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 400, sigmaY: 400),
              child: Container(color: Colors.transparent))),
    ]))));
  }
}
