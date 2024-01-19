import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:dimipay_pos_flutter/app/widgets/number_controller.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const double buttonHeight = 64;
const double buttonWidth = 64;

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
            height: buttonHeight,
            width: buttonWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: NumberController.to.pressed &&
                      NumberController.to.pressedNumber.contains(number)
                  ? DPColors.grayscale500
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
    return Container(
        constraints: const BoxConstraints(maxWidth: 280),
        padding: const EdgeInsets.fromLTRB(
            34 - buttonWidth * 0.5,
            52 - buttonHeight * 0.5,
            34 - buttonWidth * 0.5,
            52 - buttonHeight * 0.5),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          for (int i = 0; i < NumberController.to.numbers.length - 1; i += 3)
            Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                for (int j = i; j < i + 3; j++)
                  NumberPadButton(number: NumberController.to.numbers[j])
              ]),
              const SizedBox(height: 96 - buttonHeight)
            ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const SizedBox(width: buttonWidth, height: buttonHeight),
            NumberPadButton(number: NumberController.to.numbers[9]),
            GestureDetector(
                onTapDown: (_) => NumberController.to.down(10),
                onTapUp: (_) => NumberController.to.up(10),
                child: Container(
                    height: buttonHeight,
                    width: buttonWidth,
                    color: NumberController.to.pressed &&
                            NumberController.to.pressedNumber.contains(10)
                        ? DPColors.grayscale500
                        : Colors.transparent,
                    child: const DPIcons(Symbols.backspace_rounded)))
          ])
        ]));
  }
}
