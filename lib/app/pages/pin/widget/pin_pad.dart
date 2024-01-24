import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dimipay_pos_flutter/app/pages/pin/controller.dart';

const double buttonHeight = 72;
const double buttonWidth = 72;

class PinPadButton extends StatelessWidget {
  const PinPadButton({required this.number, super.key});

  final int number;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (_) => PinPageController.to.down(number),
        onTapUp: (_) => PinPageController.to.up(number),
        onTapCancel: () => PinPageController.to.canceled(),
        behavior: HitTestBehavior.translucent,
        child: Obx(() {
          return Container(
            height: 72,
            width: 72,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: PinPageController.to.isPressed &&
                      PinPageController.to.pressedPin.contains(number)
                  ? DPColors.grayscale200
                  : Colors.transparent,
            ),
            alignment: Alignment.center,
            child: Text(number.toString(),
                style: TextStyle(
                  fontFamily: 'SUITv1',
                  fontSize: 28,
                  fontWeight: DPTypography.weight.medium,
                  color: DPColors.grayscale800,
                  height: 32 / 28,
                )),
          );
        }));
  }
}

class PinPad extends StatelessWidget {
  const PinPad({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.vertical,
        spacing: 64,
        children: [
          for (int i = 0; i < PinPageController.to.numbers.length - 1; i += 3)
            Wrap(spacing: 40, children: [
              for (int j = i; j < i + 3; j++)
                PinPadButton(number: PinPageController.to.numbers[j])
            ]),
          Wrap(spacing: 40, children: [
            const SizedBox(width: buttonWidth, height: buttonHeight),
            PinPadButton(number: PinPageController.to.numbers[9]),
            GestureDetector(
                onTapDown: (_) => PinPageController.to.down(10),
                onTapUp: (_) => PinPageController.to.up(10),
                child: Obx(() {
                  return Container(
                      height: buttonHeight,
                      width: buttonWidth,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: PinPageController.to.isPressed &&
                                  PinPageController.to.pressedPin.contains(10)
                              ? DPColors.grayscale200
                              : Colors.transparent),
                      child: const DPIcons(Symbols.backspace_rounded));
                }))
          ])
        ]);
  }
}
