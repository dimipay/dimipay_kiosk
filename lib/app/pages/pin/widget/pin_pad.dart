import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:dimipay_design_kit/utils/dimipay_typography.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/pages/pin/controller.dart';

const double buttonHeight = 72;
const double buttonWidth = 72;

class PinPadButton extends StatelessWidget {
  const PinPadButton({required this.index, super.key});

  final int index;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTapDown: (_) =>
            PinPageController.to.down(PinPageController.to.numbers[index]),
        onTapUp: (_) =>
            PinPageController.to.up(PinPageController.to.numbers[index]),
        onTapCancel: () => PinPageController.to.canceled(),
        behavior: HitTestBehavior.translucent,
        child: Obx(
          () {
            return Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: PinPageController.to.isPressed &&
                        PinPageController.to.pressedPin
                            .contains(PinPageController.to.numbers[index])
                    ? DPColors.grayscale200
                    : Colors.transparent,
              ),
              alignment: Alignment.center,
              child: Text(
                PinPageController.to.numbers[index].toString(),
                style: TextStyle(
                  fontFamily: 'SUITv1',
                  fontSize: 28,
                  fontWeight: DPTypography.weight.medium,
                  color: DPColors.grayscale800,
                  height: 32 / 28,
                ),
              ),
            );
          },
        ),
      );
}

class PinPad extends StatelessWidget {
  const PinPad({super.key});

  @override
  Widget build(BuildContext context) => Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.vertical,
        spacing: 64,
        children: [
          for (int i = 0; i < PinPageController.to.numbers.length - 1; i += 3)
            Wrap(
              spacing: 40,
              children: [
                for (int j = i; j < i + 3; j++) PinPadButton(index: j)
              ],
            ),
          Wrap(
            spacing: 40,
            children: [
              AuthService.to.isAuthenticated
                  ?
                  // GestureDetector(
                  //     onTapDown: (_) => PinPageController.to.down(11),
                  //     onTapUp: (_) => PinPageController.to.up(11),
                  //     onTapCancel: () => PinPageController.to.canceled(),
                  //     child: Obx(
                  //       () => Container(
                  //         height: buttonHeight,
                  //         width: buttonWidth,
                  //         alignment: Alignment.center,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(12),
                  //           color: PinPageController.to.isPressed &&
                  //                   PinPageController.to.pressedPin.contains(11)
                  //               ? DPColors.grayscale200
                  //               : Colors.transparent,
                  //         ),
                  //         child: Text("취소", style: DPTypography.description()),
                  //       ),
                  //     ),
                  //   )
                  GestureDetector(
                      onTapDown: (_) => PinPageController.to.down(11),
                      onTapUp: (_) => PinPageController.to.up(11),
                      onTapCancel: () => PinPageController.to.canceled(),
                      child: Obx(
                        () => Container(
                          height: buttonHeight,
                          width: buttonWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: PinPageController.to.isPressed &&
                                    PinPageController.to.pressedPin.contains(11)
                                ? DPColors.grayscale200
                                : Colors.transparent,
                          ),
                          child: const DPIcons(Symbols.undo_rounded),
                        ),
                      ),
                    )
                  : const SizedBox(width: buttonWidth, height: buttonHeight),
              const PinPadButton(index: 9),
              GestureDetector(
                onTapDown: (_) => PinPageController.to.down(10),
                onTapUp: (_) => PinPageController.to.up(10),
                onTapCancel: () => PinPageController.to.canceled(),
                child: Obx(
                  () => Container(
                    height: buttonHeight,
                    width: buttonWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: PinPageController.to.isPressed &&
                              PinPageController.to.pressedPin.contains(10)
                          ? DPColors.grayscale200
                          : Colors.transparent,
                    ),
                    child: const DPIcons(Symbols.backspace_rounded),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}
