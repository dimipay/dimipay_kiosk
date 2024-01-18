import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class NumPad extends StatelessWidget {
  const NumPad({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> numbers = List.generate(10, (index) => index);
    numbers.shuffle();

    Widget numButton(int number) {
      // return Container(
      //   width: 20,
      //   alignment: Alignment.center,
      //   child: Text(
      //     number.toString(),
      //     style: TextStyle(
      //       fontFamily: 'SUIT',
      //       fontSize: 28,
      //       fontWeight: DPTypography.weight.medium,
      //       color: DPColors.grayscale800,
      //       height: 32 / 28,
      //     ),
      //     textAlign: TextAlign.center,
      //   ),
      // );
      return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            print(number);
          },
          child: Container(
              width: 20,
              alignment: Alignment.center,
              child: Text(number.toString(),
                  style: TextStyle(
                    fontFamily: 'SUIT',
                    fontSize: 28,
                    fontWeight: DPTypography.weight.medium,
                    color: DPColors.grayscale800,
                    height: 32 / 28,
                  ))));
    }

    void write() {
      print("write");
    }

    return Container(
        constraints: const BoxConstraints(maxWidth: 280),
        padding: const EdgeInsets.fromLTRB(24, 36, 24, 36),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          for (int i = 0; i < numbers.length - 1; i += 3)
            Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                for (int j = i; j < i + 3; j++) numButton(numbers[j])
              ]),
              const SizedBox(height: 64)
            ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 32, height: 32),
              numButton(numbers[9]),
              GestureDetector(
                onTap: () {},
                child: const DPIcons(Symbols.backspace_rounded),
              )
            ],
          )
        ]));
  }
}
