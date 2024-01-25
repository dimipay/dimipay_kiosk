import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dimipay_pos_flutter/app/pages/product/widget/product_list.dart';
import 'package:dimipay_pos_flutter/app/pages/product/widget/product_desk.dart';
import 'package:dimipay_pos_flutter/app/pages/product/widget/product_bar.dart';
import 'package:dimipay_pos_flutter/app/pages/product/controller.dart';

class ProductPage extends GetView<ProductPageController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
            child: Column(
                children: [ProductBar(), ProductList(), ProductDesk()])));
  }
}
