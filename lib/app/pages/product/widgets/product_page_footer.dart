import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dimipay_design_kit/interfaces/dimipay_colors.dart';
import 'package:dimipay_design_kit/interfaces/dimipay_typography.dart';
import 'package:dimipay_kiosk/app/pages/product/controller.dart';
import 'package:dimipay_kiosk/app/widgets/button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:popover/popover.dart';

class ProductPageFooter extends GetView<ProductPageController> {
  const ProductPageFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<DPColors>()!;
    final textTheme = Theme.of(context).extension<DPTypography>()!;

    return Padding(
      padding: const EdgeInsets.all(36),
      child: Column(
        children: [
          Row(
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
                        onTap: () {
                          controller.faceDetectionStatus.value ==
                                  FaceDetectionStatus.detected
                              ? controller.faceSignPayment()
                              : controller.qrPayment();
                        },
                        child: Text(
                          "결제하기",
                          style: textTheme.header1
                              .copyWith(color: colorTheme.grayscale100),
                        ),
                      ),
              )
            ],
          ),
          Obx(() {
            if (controller.isPaymentMethodSelectable.value) {
              return _buildPaymentMethodSelection(
                  context, colorTheme, textTheme);
            } else {
              return SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSelection(
      BuildContext context, DPColors colorTheme, DPTypography textTheme) {
    return Obx(() => Container(
          margin: const EdgeInsets.only(top: 36),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            color: colorTheme.grayscale200,
            border: Border.all(
              color: colorTheme.grayscale300,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                width: 48,
                height: 48,
                controller.getLogoImagePath(
                    controller.selectedPaymentMethod.value!.cardCode),
              ),
              const SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.selectedPaymentMethod.value!.name,
                    style: textTheme.header2
                        .copyWith(color: colorTheme.grayscale800),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '이 카드로 결제',
                    style: textTheme.itemTitle.copyWith(
                      color: colorTheme.grayscale600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const PaymentSelectionButton(),
            ],
          ),
        ));
  }
}

class PaymentSelectionButton extends GetView<ProductPageController> {
  const PaymentSelectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<DPColors>()!;
    final textTheme = Theme.of(context).extension<DPTypography>()!;
    return DPGestureDetectorWithOpacityInteraction(
      onTap: () {
        showPopover(
          radius: 12,
          context: context,
          direction: PopoverDirection.top,
          bodyBuilder: (context) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Text(
                    "다른 결제 수단 선택하기",
                    style: textTheme.header1
                        .copyWith(color: colorTheme.grayscale1000),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 400,
                  child: Column(
                    children: controller.user!.paymentMethods.methods
                        .map((method) => DPGestureDetectorWithFillInteraction(
                              onTap: () {
                                controller.updateSelectedPaymentMethod(method);
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      width: 48,
                                      height: 48,
                                      controller
                                          .getLogoImagePath(method.cardCode),
                                    ),
                                    const SizedBox(width: 24),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          method.name,
                                          style: textTheme.header2.copyWith(
                                              color: colorTheme.grayscale800),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${method.cardCode} (${method.preview})',
                                          style: textTheme.itemTitle.copyWith(
                                            color: colorTheme.grayscale600,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Text(
        '변경',
        style: textTheme.header1.copyWith(
          fontWeight: FontWeight.w400,
          color: colorTheme.grayscale500,
          decoration: TextDecoration.underline,
          decorationColor: colorTheme.grayscale500,
        ),
      ),
    );
  }
}
