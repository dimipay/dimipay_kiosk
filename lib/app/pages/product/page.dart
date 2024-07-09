import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:dimipay_kiosk/app/pages/product/widget/product_list.dart';
import 'package:dimipay_kiosk/app/pages/product/widget/product_desk.dart';
import 'package:dimipay_kiosk/app/pages/product/widget/product_bar.dart';
import 'package:dimipay_kiosk/app/services/face_sign/service.dart';
import 'package:dimipay_kiosk/app/services/product/service.dart';
import 'package:dimipay_kiosk/app/pages/product/controller.dart';
import 'package:dimipay_kiosk/app/widgets/barcode_scanner.dart';

class ProductPage extends GetView<ProductPageController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ProductPageController.to.resetTimer();
      FaceSignService.to.findUser();
    });

    return BarcodeScanner(
        onKey: (input) {
          ProductService.to.addProduct(input);
          ProductPageController.to.resetTimer();
        },
        child: const Scaffold(
            body: SafeArea(
                child: Column(children: [
          ProductBar(),
          ProductList(),
          ProductDesk(),
          // Obx(() => Image.memory(FaceSignService.to.imageSample.value))
        ]))));
  }
}
