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
      onKey: (input) async {
        controller.getProduct(barcode: input);
      },
      child: Scaffold(
        body: Column(
          children: [
            const ProductPageHeader(),
            const Expanded(
              child: ProductPageList(),
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () => controller.updateFaceDetectionStatus(
                        FaceDetectionStatus.searching),
                    child: const Text('searching')),
                const SizedBox(width: 8),
                ElevatedButton(
                    onPressed: () => controller.updateFaceDetectionStatus(
                        FaceDetectionStatus.detected),
                    child: const Text('detected')),
                const SizedBox(width: 8),
                ElevatedButton(
                    onPressed: () => controller
                        .updateFaceDetectionStatus(FaceDetectionStatus.failed),
                    child: const Text('failed')),
              ],
            ),
            const ProductPageFooter(),
          ],
        ),
      ),
    );
  }
}
