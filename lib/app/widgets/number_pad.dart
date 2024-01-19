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
        onTapDown: (_) => Get.find<NumberController>().pressed(number),
        onTapUp: (_) => Get.find<NumberController>().released(number),
        onTapCancel: () => Get.find<NumberController>().canceled(),
        behavior: HitTestBehavior.translucent,
        child: Obx(() {
          return Container(
            height: buttonHeight,
            width: buttonWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Get.find<NumberController>().isPressed &&
                      Get.find<NumberController>()
                          .pressedNumber
                          .contains(number)
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
    List<int> numbers = List.generate(10, (index) => index);
    numbers.shuffle();
    Get.lazyPut(() => NumberController());
    Get.find<NumberController>().init(numbers);

    return Container(
        constraints: const BoxConstraints(maxWidth: 280),
        padding: const EdgeInsets.fromLTRB(
            34 - buttonWidth * 0.5,
            52 - buttonHeight * 0.5,
            34 - buttonWidth * 0.5,
            52 - buttonHeight * 0.5),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          for (int i = 0; i < numbers.length - 1; i += 3)
            Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                for (int j = i; j < i + 3; j++)
                  NumberPadButton(number: numbers[j])
              ]),
              const SizedBox(height: 96 - buttonHeight)
            ]),
          Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: buttonWidth * 0.5 - 10, vertical: 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 32, height: 32),
                    NumberPadButton(number: numbers[9]),
                    GestureDetector(
                        onTap: () {},
                        child: const DPIcons(Symbols.backspace_rounded))
                  ]))
        ]));
  }
}
