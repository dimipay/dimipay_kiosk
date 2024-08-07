import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:dimipay_kiosk/app/pages/product/widget/product_list.dart';
import 'package:dimipay_kiosk/app/pages/product/widget/product_desk.dart';
import 'package:dimipay_kiosk/app/pages/product/widget/product_bar.dart';
import 'package:dimipay_kiosk/app/services/transaction/service.dart';
import 'package:dimipay_kiosk/app/services/face_sign/service.dart';
import 'package:dimipay_kiosk/app/services/product/service.dart';
import 'package:dimipay_kiosk/app/pages/product/controller.dart';
import 'package:dimipay_kiosk/app/widgets/barcode_scanner.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/services/qr/service.dart';

class ProductPage extends GetView<ProductPageController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    var timer = Timer(const Duration(minutes: 1), () => ProductService.to.clearProduct());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FaceSignService.to.findUser();
      TransactionService.to.transactionId;
      AuthService.to.createEncryptionKey();
    });

    return BarcodeScanner(
      onKey: (input) async {
        if (input.substring(0, 3) == "_DP") {
          await QRService.to.approvePayment(input);
        } else {
          ProductService.to.addProduct(input);
        }
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          timer.cancel();
          timer = Timer(const Duration(minutes: 1), () => ProductService.to.clearProduct());
        },
        child: const Scaffold(
          body: SafeArea(
            child: Column(children: [ProductBar(), ProductList(), ProductDesk()]),
          ),
        ),
      ),
    );
  }
}
