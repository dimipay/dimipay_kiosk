import 'package:dimipay_design_kit/interfaces/dimipay_colors.dart';
import 'package:dimipay_design_kit/interfaces/dimipay_typography.dart';
import 'package:dimipay_kiosk/app/pages/product/controller.dart';
import 'package:dimipay_kiosk/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPageFooter extends GetView<ProductPageController> {
  const ProductPageFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<DPColors>()!;
    final textTheme = Theme.of(context).extension<DPTypography>()!;

    return Padding(
      padding: const EdgeInsets.all(36),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  '${controller.productItems.fold<int>(0, (sum, item) => sum + item.amount)}개 상품',
                  style: textTheme.header1.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colorTheme.grayscale700,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Obx(
                () => Text(
                  '${controller.productItems.fold<int>(0, (sum, item) => sum + item.price * item.amount)}원',
                  style: textTheme.header1.copyWith(
                    fontSize: 36,
                    color: colorTheme.primaryBrand,
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () => controller.productItems.isEmpty
                ? DPButton.disabled(
                    child: Text(
                      "결제하기",
                      style: textTheme.header1
                          .copyWith(color: colorTheme.grayscale100),
                    ),
                  )
                : DPButton(
                    onTap: () {},
                    child: Text(
                      "결제하기",
                      style: textTheme.header1
                          .copyWith(color: colorTheme.grayscale100),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
