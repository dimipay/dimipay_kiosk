import 'dart:async';

import 'package:get/get.dart';

class Spot {
  final double size;
  final int color;
  final RxDouble left;
  final RxDouble top;
  final Map<String, double> animatedPosition;

  Spot({
    required this.size,
    required this.color,
    required this.left,
    required this.top,
    required this.animatedPosition,
  });
}

class PaymentPageController extends GetxController {
  static PaymentPageController get to => Get.find<PaymentPageController>();

  final _turns = RxDouble(0.0);
  final _backgroundSpot = <Spot>[
    Spot(
        size: 169.14,
        color: 0xFFFF0000,
        left: RxDouble(723.54 + 512),
        top: RxDouble(25.41 - 169.14 - 512),
        animatedPosition: {
          'left': 723.54 - 249.12,
          'top': 25.41,
        }),
    Spot(
        size: 169.14,
        color: 0xFFFF0000,
        left: RxDouble(693.37 + 512),
        top: RxDouble(1023.09 - 169.14 - 512),
        animatedPosition: {
          'left': 693.37 - 249.12,
          'top': 1023.09,
        }),
    Spot(
        size: 249.12,
        color: 0xFF00C2FF,
        left: RxDouble(759.52 + 512),
        top: RxDouble(725.2 - 249.12 - 512),
        animatedPosition: {
          'left': 759.52 - 249.12,
          'top': 725.2,
        }),
    Spot(
        size: 249.12,
        color: 0xFF00C2FF,
        left: RxDouble(544.77 + 512),
        top: RxDouble(425.58 - 249.12 - 512),
        animatedPosition: {
          'left': 544.77 - 249.12,
          'top': 425.58,
        }),
    Spot(
        size: 249.12,
        color: 0xFF00FF7A,
        left: RxDouble(778.22),
        top: RxDouble(316.23 - 249.12),
        animatedPosition: {
          'left': 778.22 - 249.12,
          'top': 316.23,
        }),
    Spot(
        size: 250.96,
        color: 0xFF4200FF,
        left: RxDouble(361.67 + 512),
        top: RxDouble(23.19 + 512),
        animatedPosition: {
          'left': 361.67 - 250.96,
          'top': 23.19,
        }),
    Spot(
        size: 328.0,
        color: 0xFFFF7A00,
        left: RxDouble(378.67 - 328 - 512),
        top: RxDouble(798.71 + 512),
        animatedPosition: {
          'left': 378.67 - 328,
          'top': 798.71,
        }),
  ];

  get backgroundSpot => _backgroundSpot;
  get turns => _turns.value;

  @override
  void onInit() {
    super.onInit();

    Timer(const Duration(milliseconds: 500), () {
      for (var spot in _backgroundSpot) {
        spot.left.value = spot.animatedPosition['left']!;
        spot.top.value = spot.animatedPosition['top']!;
      }
      _turns.value++;
      turnBackground();
    });
  }

  void turnBackground() {
    Timer(const Duration(milliseconds: 5000), () {
      _turns.value++;
      turnBackground();
    });
  }
}
