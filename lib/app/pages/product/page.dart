import 'package:dimipay_kiosk/app/pages/product/controller.dart';
import 'package:dimipay_kiosk/app/widgets/barcode_scanner.dart';
import 'package:dimipay_kiosk/app/pages/product/widgets/product_page_header.dart';
import 'package:dimipay_kiosk/app/pages/product/widgets/product_page_list.dart';
import 'package:dimipay_kiosk/app/pages/product/widgets/product_page_footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends GetView<ProductPageController> {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarcodeScanner(
      onScan: (input) async {
        controller.getProduct(barcode: input);
      },
      child: const Scaffold(
        body: Column(
          children: [
            ProductPageHeaderDetected(),
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
