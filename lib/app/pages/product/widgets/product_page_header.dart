import 'package:dimipay_design_kit/interfaces/dimipay_colors.dart';
import 'package:dimipay_design_kit/interfaces/dimipay_typography.dart';
import 'package:dimipay_kiosk/app/pages/product/controller.dart';
import 'package:dimipay_kiosk/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPageHeaderSearching extends GetView<ProductPageController> {
  const ProductPageHeaderSearching({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<DPColors>()!;
    final textTheme = Theme.of(context).extension<DPTypography>()!;

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
          const Spacer(),
          _buildAddButton('마이쮸 추가', '8801111187893'),
          const SizedBox(width: 16),
          _buildAddButton('오미자 추가', '8801047289685'),
        ],
      ),
    );
  }

  Widget _buildAddButton(String label, String barcode) {
    return ElevatedButton(
      onPressed: () => controller.getProduct(barcode: barcode),
      child: Text(label),
    );
  }
}

class ProductPageHeaderDetected extends GetView<ProductPageController> {
  const ProductPageHeaderDetected({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<DPColors>()!;
    final textTheme = Theme.of(context).extension<DPTypography>()!;

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
              onTap: () => {},
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

  Widget _buildAddButton(String label, String barcode) {
    return ElevatedButton(
      onPressed: () => controller.getProduct(barcode: barcode),
      child: Text(label),
    );
  }
}

class ProductPageHeaderFailed extends GetView<ProductPageController> {
  const ProductPageHeaderFailed({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<DPColors>()!;
    final textTheme = Theme.of(context).extension<DPTypography>()!;

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
              onTap: () => {},
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
