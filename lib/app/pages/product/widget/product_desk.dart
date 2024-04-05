import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/services/face_sign/service.dart';
import 'package:dimipay_kiosk/app/services/product/service.dart';
import 'package:dimipay_kiosk/app/pages/product/controller.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';

class ProductSelection extends StatelessWidget {
  const ProductSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
      decoration: BoxDecoration(
        color: DPColors.grayscale200,
        border: Border.all(color: DPColors.grayscale300, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            spacing: 24,
            children: [
              const SizedBox(width: 48, height: 48),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "X CHECK",
                    style: DPTypography.header2(color: DPColors.grayscale800),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "이 카드로 결제",
                    style:
                        DPTypography.description(color: DPColors.grayscale600),
                  )
                ],
              ),
            ],
          ),
          Text(
            "변경",
            style: DPTypography.pos.underlined(color: DPColors.grayscale500),
          ),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text("${ProductService.to.productTotalCount}개 상품",
                      style: DPTypography.pos.itemDescription())),
                  const SizedBox(height: 8),
                  Obx(
                    () => Text(
                      "${ProductService.to.productTotalPrice}원",
                      style: DPTypography.pos.title(
                        color: DPColors.primaryBrand,
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTapDown: (_) =>
                    ProductPageController.to.pressedButton = "pay",
                onTapCancel: () => ProductPageController.to.pressedButton = "",
                onTapUp: (_) {
                  ProductPageController.to.pressedButton = "";
                  if (FaceSignService.to.faceSignStatus ==
                      FaceSignStatus.success) {
                    Get.toNamed(Routes.PIN);
                  } else {
                    Get.toNamed(Routes.PAYMENT);
                  }
                },
                child: Obx(
                  () => Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
                    decoration: ShapeDecoration(
                      color: ProductPageController.to.pressedButton == "pay"
                          ? Color.alphaBlend(
                              DPColors.grayscale600.withOpacity(0.5),
                              DPColors.primaryBrand)
                          : DPColors.primaryBrand,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x332EA4AB),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: Text(
                      "결제하기",
                      style: DPTypography.pos.itemTitle(
                        color: DPColors.grayscale100,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () {
              return FaceSignService.to.faceSignStatus == FaceSignStatus.success
                  ? const Column(
                      children: [
                        SizedBox(height: 36),
                        ProductSelection(),
                      ],
                    )
                  : const SizedBox(height: 0);
            },
          ),
        ],
      ),
    );
  }
}
