import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/pages/pin/controller.dart';

import 'gesture_detector.dart';

class PinPadButton extends GetView<PinPageController> {
  const PinPadButton({required this.index, this.child, super.key});

  final int index;
  final Widget? child;

  @override
  Widget build(BuildContext context) => DPGestureDetectorWithOpacityInteraction(
    onTap: () => controller.up(index),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
      ),
      alignment: Alignment.center,
      child: child ?? Obx(() => Text(
        controller.numbers[index].toString(),
        style: TextStyle(
          fontFamily: 'SUITv1',
          fontSize: 28,
          fontWeight: DPTypography.weight.medium,
          color: DPColors.grayscale800,
          height: 32 / 28,
        ),
      )),
    ),
  );
}

class PinPad extends GetView<PinPageController> {
  const PinPad({super.key});

  @override
  Widget build(BuildContext context) => Container(
    width: 300,
    height: 480,
    child: LayoutBuilder(
      builder: (context, constraints) {
        return GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: (constraints.maxWidth / 3) / (constraints.maxHeight / 4),
          children: [
            for (int i = 0; i < 9; i++) PinPadButton(index: i),
            Obx(() => AuthService.to.isAuthenticated
                ? const PinPadButton(
              index: 11,
              child: DPIcons(Symbols.undo_rounded),
            )
                : const SizedBox()),
            const PinPadButton(index: 9),
            Obx(() => PinPadButton(
              index: 10,
              child: DPIcons(
                Symbols.backspace_rounded,
                color: controller.canDelete ? DPColors.grayscale800 : DPColors.grayscale500,
              ),
            )),
          ],
        );
      },
    ),
  );
}