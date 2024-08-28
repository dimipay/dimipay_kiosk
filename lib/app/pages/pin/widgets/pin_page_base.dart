import 'dart:async';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:dimipay_kiosk/app/pages/pin/controller.dart';
import 'package:dimipay_kiosk/app/pages/pin/widgets/pin_pad.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PinPageBase extends GetView<PinPageController> {
  final String headerText;
  final String subText;
  final bool popBtnAvailable;
  final FutureOr<void> Function()? onPinComplete;

  const PinPageBase({
    super.key,
    required this.headerText,
    required this.subText,
    this.onPinComplete,
    this.popBtnAvailable = true,
  });

  Widget pinHint(bool activated, DPColors colorTheme) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: 28,
      height: 28,
      decoration: ShapeDecoration(
        color: activated ? colorTheme.grayscale800 : colorTheme.grayscale300,
        shape: const OvalBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Container(
      color: colorTheme.grayscale100,
      child: SafeArea(
        bottom: true,
        child: Column(
          children: [
            const Spacer(),
            Text(
              headerText,
              style: textTheme.title.copyWith(color: colorTheme.grayscale1000),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              subText,
              style: textTheme.header2.copyWith(color: colorTheme.grayscale700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 120),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ignore: prefer_is_empty
                  pinHint(controller.pin.length > 0, colorTheme),
                  const SizedBox(width: 24),
                  pinHint(controller.pin.length > 1, colorTheme),
                  const SizedBox(width: 24),
                  pinHint(controller.pin.length > 2, colorTheme),
                  const SizedBox(width: 24),
                  pinHint(controller.pin.length > 3, colorTheme),
                ],
              ),
            ),
            const SizedBox(height: 120),
            Obx(
              () => PinPad(
                controller.nums,
                onPinTap: (data) async {
                  controller.onPinTap.call(data);
                  if (controller.pin.length == 4) {
                    try {
                      await onPinComplete?.call();
                    } finally {
                      controller.clearPin();
                    }
                  }
                },
                backBtnEnabled: controller.backBtnEnabled,
                numpadEnabled: controller.numpadEnabled,
                popBtnAvailable: popBtnAvailable,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
