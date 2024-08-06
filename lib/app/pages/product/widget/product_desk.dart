import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
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
              SizedBox(
                width: 48,
                height: 48,
                child: Obx(() => FaceSignService.to.user.paymentMethods.methods[FaceSignService.to.paymentIndex.value].image),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(FaceSignService.to.user.paymentMethods.methods[FaceSignService.to.paymentIndex.value].name, style: DPTypography.header2(color: DPColors.grayscale800)),
                  ),
                  const SizedBox(height: 4),
                  Text("이 카드로 결제", style: DPTypography.description(color: DPColors.grayscale600))
                ],
              ),
            ],
          ),
          const CardSelectButton(),
        ],
      ),
    );
  }
}

class CardSelectButton extends StatelessWidget {
  const CardSelectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (_) => ProductPageController.to.pressedButton = "change",
      onTapCancel: () => ProductPageController.to.pressedButton = "",
      onTapUp: (_) {
        ProductPageController.to.pressedButton = "";
        showPopover(
          radius: 12,
          context: context,
          direction: PopoverDirection.top,
          bodyBuilder: (context) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Text("다른 결제 수단 선택하기", style: DPTypography.header1(color: DPColors.grayscale1000)),
                ),
                for (int i = 0; i < FaceSignService.to.user.paymentMethods.methods.length; i++)
                  Column(
                    children: [
                      const SizedBox(height: 8),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTapDown: (_) => ProductPageController.to.pressedButton = "$i",
                        onTapCancel: () => ProductPageController.to.pressedButton = "",
                        onTapUp: (_) {
                          FaceSignService.to.paymentIndex.value = i;
                          ProductPageController.to.pressedButton = "";
                          Navigator.of(context).pop();
                        },
                        child: Obx(
                          () => Container(
                            width: 374,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: ProductPageController.to.pressedButton == "$i" ? DPColors.grayscale300 : DPColors.grayscale100,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FaceSignService.to.user.paymentMethods.methods[i].image,
                                const SizedBox(width: 24),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(FaceSignService.to.user.paymentMethods.methods[i].name, style: DPTypography.header2(color: DPColors.grayscale800)),
                                    Text("${FaceSignService.to.user.paymentMethods.methods[i].cardCode} (${FaceSignService.to.user.paymentMethods.methods[i].preview})",
                                        style: DPTypography.itemTitle(color: DPColors.grayscale600))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
      child: Obx(
        () => Text(
          "변경",
          style: DPTypography.pos.underlined(
            color: ProductPageController.to.pressedButton == "change" ? DPColors.grayscale700 : DPColors.grayscale500,
          ),
        ),
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
                  Obx(() => Text("${ProductService.to.productTotalCount}개 상품", style: DPTypography.pos.itemDescription())),
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
                onTapDown: (_) => ProductPageController.to.pressedButton = "pay",
                onTapCancel: () => ProductPageController.to.pressedButton = "",
                onTapUp: (_) async {
                  ProductPageController.to.pressedButton = "";
                  if (FaceSignService.to.faceSignStatus == FaceSignStatus.success) {
                    if (FaceSignService.to.isRetry) {
                      await FaceSignService.to.approvePayment();
                    }
                    Get.toNamed(Routes.PIN);
                  } else {
                    Get.toNamed(Routes.PAYMENT);
                  }
                },
                child: Obx(
                  () => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    decoration: ShapeDecoration(
                      color: ProductPageController.to.pressedButton == "pay" ? Color.alphaBlend(DPColors.grayscale600.withOpacity(0.5), DPColors.primaryBrand) : DPColors.primaryBrand,
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
              return FaceSignService.to.faceSignStatus == FaceSignStatus.success ? const Column(children: [SizedBox(height: 36), ProductSelection()]) : const SizedBox(height: 0);
            },
          ),
        ],
      ),
    );
  }
}
