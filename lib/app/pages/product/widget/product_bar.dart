import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';

import 'package:dimipay_kiosk/app/pages/product/controller.dart';

class ProductBar extends StatelessWidget {
  const ProductBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(36),
        child: Wrap(spacing: 36, children: [
          Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: DPColors.grayscale300, width: 1),
              )),
          Text(
              true
                  // ProductService.to.faceRecognitionLoading
                  ? "얼굴 인식 중..."
                  : false
                      // : ProductService.to.faceRecognitionSuccessed
                      ? "김형석님"
                      : "얼굴 인식에 실패했습니다",
              style: DPTypography.header1(color: DPColors.grayscale600)),
          // Image.asset(
          //   "assets/images/logo.png",
          //   width: 100,
          // ),
        ]));
  }
}
