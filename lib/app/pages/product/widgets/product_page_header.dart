import 'package:dimipay_kiosk/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dimipay_design_kit/interfaces/dimipay_colors.dart';
import 'package:dimipay_design_kit/interfaces/dimipay_typography.dart';
import 'package:dimipay_kiosk/app/pages/product/controller.dart';

class ProductPageHeader extends GetView<ProductPageController> {
  const ProductPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<DPColors>()!;
    final textTheme = Theme.of(context).extension<DPTypography>()!;

    return Obx(() {
      switch (controller.faceDetectionStatus.value) {
        case FaceDetectionStatus.searching:
          return _buildSearchingHeader(context, colorTheme, textTheme);
        case FaceDetectionStatus.detected:
          return _buildDetectedHeader(context, colorTheme, textTheme);
        case FaceDetectionStatus.failed:
          return _buildFailedHeader(context, colorTheme, textTheme);
      }
    });
  }

  Widget _buildSearchingHeader(
      BuildContext context, DPColors colorTheme, DPTypography textTheme) {
    return Padding(
      padding: const EdgeInsets.all(36),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: colorTheme.grayscale100,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: colorTheme.grayscale300,
                width: 1,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            '얼굴 인식 중...',
            style: textTheme.header1.copyWith(
              fontWeight: FontWeight.w500,
              color: colorTheme.grayscale800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetectedHeader(
      BuildContext context, DPColors colorTheme, DPTypography textTheme) {
    return Padding(
      padding: const EdgeInsets.all(36),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
          ),
          const SizedBox(width: 16),
          Text(
            '서승표님',
            style: textTheme.header1.copyWith(
              color: colorTheme.grayscale900,
            ),
          ),
          const Spacer(),
          DPGestureDetectorWithOpacityInteraction(
              onTap: () => controller
                  .updateFaceDetectionStatus(FaceDetectionStatus.searching),
              child: Text('얼굴 다시 인식하기',
                  style: textTheme.header1.copyWith(
                    color: Colors.black45,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.black45,
                  ))),
        ],
      ),
    );
  }

  Widget _buildFailedHeader(
      BuildContext context, DPColors colorTheme, DPTypography textTheme) {
    return Padding(
      padding: const EdgeInsets.all(36),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: colorTheme.grayscale100,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: colorTheme.primaryNegative,
                width: 1,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            '얼굴 인식에 실패했습니다',
            style: textTheme.header1.copyWith(
              fontWeight: FontWeight.w500,
              color: colorTheme.grayscale800,
            ),
          ),
          const Spacer(),
          DPGestureDetectorWithOpacityInteraction(
              onTap: () => controller
                  .updateFaceDetectionStatus(FaceDetectionStatus.searching),
              child: Text('다시 인식하기',
                  style: textTheme.header1.copyWith(
                    color: Colors.black45,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.black45,
                  ))),
        ],
      ),
    );
  }
}
