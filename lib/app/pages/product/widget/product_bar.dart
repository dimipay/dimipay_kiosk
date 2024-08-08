import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/services/face_sign/service.dart';
import 'package:dimipay_kiosk/app/pages/product/controller.dart';

class ProductBar extends StatelessWidget {
  const ProductBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(36),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            spacing: 36,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Obx(
                () => Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: FaceSignService.to.faceSignStatus == FaceSignStatus.success
                        ? null
                        : Border.all(
                            color: FaceSignService.to.faceSignStatus == FaceSignStatus.loading ? DPColors.grayscale300 : DPColors.primaryNegative,
                            width: 1,
                          ),
                    image: FaceSignService.to.faceSignStatus == FaceSignStatus.success
                        ? DecorationImage(
                            image: NetworkImage(
                              FaceSignService.to.user.profileImage,
                            ),
                          )
                        : null,
                  ),
                ),
              ),
              Obx(
                () => Text(
                  FaceSignService.to.faceSignStatus == FaceSignStatus.loading
                      ? "얼굴 인식 중..."
                      : FaceSignService.to.faceSignStatus == FaceSignStatus.success
                          ? "${FaceSignService.to.user.name}님"
                          : "얼굴 인식에 실패했습니다",
                  style: DPTypography.pos.itemDescription(color: DPColors.grayscale800),
                ),
              ),
            ],
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTapDown: (_) => ProductPageController.to.pressButton("retry"),
            onTapUp: (_) {
              ProductPageController.to.resetButton();
              FaceSignService.to.findUser();
            },
            onTapCancel: () => ProductPageController.to.resetButton(),
            child: Obx(
              () => Text(
                FaceSignService.to.faceSignStatus == FaceSignStatus.loading ? "" : "얼굴 다시 인식하기",
                style: TextStyle(
                  color: ProductPageController.to.isPressed("retry") ? DPColors.grayscale800 : DPColors.grayscale600,
                  height: 1.25,
                  letterSpacing: -0.48,
                  decoration: TextDecoration.underline,
                  decorationColor: DPColors.grayscale600,
                  decorationThickness: 1,
                  fontWeight: DPTypography.weight.semiBold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
