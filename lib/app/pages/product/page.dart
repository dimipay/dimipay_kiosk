import 'package:dimipay_kiosk/app/pages/product/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProductPage extends GetView<ProductPageController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Pin Page'),
      ),
    );
  }
}
