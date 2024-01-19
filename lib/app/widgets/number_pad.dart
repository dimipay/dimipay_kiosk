import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:dimipay_pos_flutter/app/widgets/number_controller.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const double buttonHeight = 72;
const double buttonWidth = 72;

class NumberPadButton extends StatelessWidget {
  const NumberPadButton({required this.number, super.key});

  final int number;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (_) => NumberController.to.down(number),
        onTapUp: (_) => NumberController.to.up(number),
        onTapCancel: () => NumberController.to.canceled(),
        behavior: HitTestBehavior.translucent,
        child: Obx(() {
          return Container(
            height: 72,
            width: 72,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: NumberController.to.pressed &&
                      NumberController.to.pressedNumber.contains(number)
                  ? DPColors.grayscale200
                  : Colors.transparent,
            ),
            alignment: Alignment.center,
            child: Text(number.toString(),
                style: TextStyle(
                  fontFamily: 'SUIT',
                  fontSize: 28,
                  fontWeight: DPTypography.weight.medium,
                  color: DPColors.grayscale800,
                  height: 32 / 28,
                )),
          );
        }));
  }
}

class NumberPad extends StatelessWidget {
  const NumberPad({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.vertical,
      spacing: 64,
      children: [
        for (int i = 0; i < NumberController.to.numbers.length - 1; i += 3)
          Wrap(spacing: 40, children: [
            for (int j = i; j < i + 3; j++)
              NumberPadButton(number: NumberController.to.numbers[j])
          ]),
        Wrap(
          spacing: 40,
          children: [
            const SizedBox(width: buttonWidth, height: buttonHeight),
            NumberPadButton(number: NumberController.to.numbers[9]),
            GestureDetector(
                onTapDown: (_) => NumberController.to.down(10),
                onTapUp: (_) => NumberController.to.up(10),
                child: Obx(() {
                  return Container(
                      height: buttonHeight,
                      width: buttonWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: NumberController.to.pressed &&
                                NumberController.to.pressedNumber.contains(10)
                            ? DPColors.grayscale200
                            : Colors.transparent,
                      ),
                      child: const DPIcons(Symbols.backspace_rounded));
                }))
          ],
        )
      ],
    );
  }
}
