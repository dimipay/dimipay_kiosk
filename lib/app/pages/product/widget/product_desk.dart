import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';

import 'package:dimipay_kiosk/app/pages/product/controller.dart';
import 'package:get/get.dart';

class ProductSelection extends StatelessWidget {
  const ProductSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            spacing: 24,
            children: [
              // Image(image: image),
              Text("카드")
            ],
          ),
          Text("변경"),
        ],
      ),
    );
  }
}

class ProductDesk extends StatelessWidget {
  const ProductDesk({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(36),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Obx(() => Text(
                  "${ProductPageController.to.productTotalCount}개 상품",
                  style: DPTypography.pos.itemDescription())),
              const SizedBox(height: 8),
              Obx(() => Text("${ProductPageController.to.productTotalPrice}원",
                  style: DPTypography.pos.title(color: DPColors.primaryBrand)))
            ]),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: ShapeDecoration(
                  color: DPColors.primaryBrand,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  shadows: const [
                    BoxShadow(
                        color: Color(0x332EA4AB),
                        blurRadius: 10,
                        offset: Offset(0, 4))
                  ],
                ),
                child: Text("결제하기",
                    style: DPTypography.pos
                        .itemTitle(color: DPColors.grayscale100)))
          ]),
          if (ProductPageController.to.faceRecognitionSuccessed)
            const SizedBox(height: 36),
          if (ProductPageController.to.faceRecognitionSuccessed)
            const ProductSelection()
        ]));
  }
}