import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/pages/product/controller.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';

class ProductBar extends StatelessWidget {
  const ProductBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(36),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Wrap(
              spacing: 36,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Obx(() => Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: AuthService.to.faceSignStatus ==
                                FaceSignStatus.success
                            ? null
                            : Border.all(
                                color: AuthService.to.faceSignStatus ==
                                        FaceSignStatus.loading
                                    ? DPColors.grayscale300
                                    : DPColors.primaryNegative,
                                width: 1),
                        image: AuthService.to.faceSignStatus ==
                                FaceSignStatus.success
                            ? DecorationImage(
                                image: NetworkImage(AuthService
                                    .to.users!.users[0].profileImage))
                            : null))),
                Obx(() => Text(
                    AuthService.to.faceSignStatus == FaceSignStatus.loading
                        ? "얼굴 인식 중..."
                        : AuthService.to.faceSignStatus ==
                                FaceSignStatus.success
                            ? "${AuthService.to.users!.users[0].name}님"
                            : "얼굴 인식에 실패했습니다",
                    style: DPTypography.pos
                        .itemDescription(color: DPColors.grayscale800))),
              ]),
          GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTapDown: (_) =>
                  ProductPageController.to.pressedButton = "retry",
              onTapUp: (_) {
                ProductPageController.to.pressedButton = "";
                AuthService.to.findUser();
              },
              onTapCancel: () => ProductPageController.to.pressedButton = "",
              child: Obx(() => Text(
                  AuthService.to.faceSignStatus == FaceSignStatus.loading
                      ? ""
                      : "얼굴 다시 인식하기",
                  style: TextStyle(
                      color: ProductPageController.to.pressedButton == "retry"
                          ? DPColors.grayscale800
                          : DPColors.grayscale600,
                      height: 1.25,
                      letterSpacing: -0.48,
                      decoration: TextDecoration.underline,
                      decorationColor: DPColors.grayscale600,
                      decorationThickness: 1,
                      fontWeight: DPTypography.weight.semiBold,
                      fontSize: 24))))
        ]));
  }
}
