import 'package:dimipay_kiosk/app/pages/product/controller.dart';
import 'package:dimipay_kiosk/app/widgets/barcode_scanner.dart';
import 'package:dimipay_kiosk/app/pages/product/widgets/product_page_header.dart';
import 'package:dimipay_kiosk/app/pages/product/widgets/product_page_list.dart';
import 'package:dimipay_kiosk/app/pages/product/widgets/product_page_footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends GetView<ProductPageController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BarcodeScanner(
      onKey: (input) async {
        if (input.startsWith('-DP') || input.startsWith('688000')) {
          controller.setDPToken(barcode: input);
        } else {
          controller.getProduct(barcode: input);
        }
      },
      child: const Scaffold(
        body: Column(
          children: [
            ProductPageHeader(),
            Expanded(
              child: ProductPageList(),
            ),
            ProductPageFooter(),
          ],
        ),
      ),
    );
  }
}
