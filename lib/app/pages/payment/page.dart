import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:dimipay_kiosk/app/pages/payment/controller.dart';

class PaymentPage extends GetView<PaymentPageController> {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SizedBox.expand(
                child: FutureBuilder<void>(
      future: PaymentPageController.to.init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
          return Obx(() => PaymentPageController.to.imageFile.value != null
              ? Image.file(File(PaymentPageController.to.imageFile.value!.path))
              : const SizedBox());
        } else {
          // Otherwise, display a loading indicator.
          return const Center(child: CircularProgressIndicator());
        }
      },
    )
                // child: Stack(alignment: Alignment.center, children: [
                // const PaymentBackground(),
                // ClipRect(
                //     child: BackdropFilter(
                //         filter: ImageFilter.blur(sigmaX: 400, sigmaY: 400),
                //         child: Container(color: Colors.transparent))),
                // ]
                // )
                )));
  }
}
