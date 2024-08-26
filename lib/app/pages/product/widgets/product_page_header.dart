import 'package:dimipay_design_kit/interfaces/dimipay_colors.dart';
import 'package:dimipay_design_kit/interfaces/dimipay_typography.dart';
import 'package:dimipay_kiosk/app/pages/product/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPageHeader extends GetView<ProductPageController> {
  const ProductPageHeader({Key? key}) : super(key: key);

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
