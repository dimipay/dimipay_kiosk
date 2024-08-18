import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/pages/pin/controller.dart';

import 'gesture_detector.dart';

class PinPadButton extends GetView<PinPageController> {
  const PinPadButton({required this.number, this.child, super.key});

  final int number;
  final Widget? child;

  @override
  Widget build(BuildContext context) => Obx(() => DPGestureDetectorWithOpacityInteraction(
    onTap: () => controller.up(number),
    onTapDown: (_) => controller.down(number),
    onTapCancel: controller.canceled,
    isPressed: controller.isPressed && controller.pressedPin.contains(number),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
      ),
      alignment: Alignment.center,
      child: child ?? Text(
        number.toString(),
        style: TextStyle(
          fontFamily: 'SUITv1',
          fontSize: 28,
          fontWeight: DPTypography.weight.medium,
          color: DPColors.grayscale800,
          height: 32 / 28,
        ),
      ),
    ),
  ));
}

class PinPad extends GetView<PinPageController> {
  const PinPad({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 340,
    height: 480,
    child: LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() => GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: (constraints.maxWidth / 3) / (constraints.maxHeight / 4),
          children: [
            for (int i = 1; i <= 9; i++) PinPadButton(number: controller.numbers[i - 1]),
            Obx(() => AuthService.to.isAuthenticated
                ? const PinPadButton(
              number: -1,
              child: DPIcons(Symbols.undo_rounded),
            )
                : const SizedBox()),
            PinPadButton(number: controller.numbers[9]),
            PinPadButton(
              number: -2,
              child: DPIcons(
                Symbols.backspace_rounded,
                color: controller.canDelete ? DPColors.grayscale800 : DPColors.grayscale500,
              ),
            ),
          ],
        ));
      },
    ),
  );
}