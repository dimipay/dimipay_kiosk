import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dimipay_design_kit/interfaces/dimipay_colors.dart';
import 'package:dimipay_design_kit/interfaces/dimipay_typography.dart';
import 'package:dimipay_kiosk/app/widgets/button.dart';
import 'package:dimipay_kiosk/app/pages/payment/controller.dart';

class PaymentPage extends GetView<PaymentPageController> {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<DPColors>()!;
    final textTheme = Theme.of(context).extension<DPTypography>()!;
    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundSpots(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildInstructions(textTheme, colorTheme),
                const SizedBox(height: 68),
                _buildProgressBar(colorTheme),
                const SizedBox(height: 24),
                _buildRemainingTime(textTheme, colorTheme),
                const SizedBox(height: 132),
                _buildBackButton(textTheme, colorTheme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructions(DPTypography textTheme, DPColors colorTheme) {
    return Column(
      children: [
        Text(
          '디미페이 앱의 결제 QR를 스캔해주세요',
          style: textTheme.title.copyWith(color: colorTheme.grayscale1000),
        ),
        const SizedBox(height: 48),
        Text(
          '상품 스캔 창에서 결제 QR를 바로 스캔하면\n빠르게 결제를 완료할 수 있습니다',
          style: textTheme.header1.copyWith(color: colorTheme.grayscale600),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildProgressBar(DPColors colorTheme) {
    return Stack(
      children: [
        Container(
          width: 420,
          height: 8,
          decoration: BoxDecoration(
            color: colorTheme.grayscale600.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Obx(() => TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 100),
              tween: Tween<double>(
                  begin: 420, end: 420 * controller.progress.value),
              builder: (context, value, child) => Container(
                width: max(0, value),
                height: 8,
                decoration: BoxDecoration(
                  color: colorTheme.grayscale900.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildRemainingTime(DPTypography textTheme, DPColors colorTheme) {
    return Obx(() => Text(
          '${controller.remainingTime.value}초',
          style: textTheme.header1.copyWith(color: colorTheme.grayscale600),
        ));
  }

  Widget _buildBackButton(DPTypography textTheme, DPColors colorTheme) {
    return DPGestureDetectorWithOpacityInteraction(
      onTap: () => Get.back(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_back_ios_new_rounded,
              size: 24, color: colorTheme.grayscale600),
          const SizedBox(width: 24),
          Text(
            '상품 스캔 화면으로 돌아가기',
            style: textTheme.header1.copyWith(color: colorTheme.grayscale1000),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundSpots() {
    return const Stack(
      children: [
        BackgroundSpot(
            left: 723.54, top: -143.99, size: 169.14, color: Color(0xFFFF0000)),
        BackgroundSpot(
            left: 693.37, top: 853.95, size: 169.14, color: Color(0xFFFF0000)),
        BackgroundSpot(
            left: 759.52, top: 476.08, size: 249.12, color: Color(0xFF00C2FF)),
        BackgroundSpot(
            left: 544.77, top: 176.46, size: 249.12, color: Color(0xFF00C2FF)),
        BackgroundSpot(
            left: 778.22, top: 67.11, size: 249.12, color: Color(0xFF00FF7A)),
        BackgroundSpot(
            left: 361.67, top: 23.19, size: 250.96, color: Color(0xFF4200FF)),
        BackgroundSpot(
            left: 50.67, top: 798.71, size: 328.0, color: Color(0xFFFF7A00)),
      ],
    );
  }
}

class BackgroundSpot extends StatelessWidget {
  const BackgroundSpot({
    super.key,
    required this.left,
    required this.top,
    required this.size,
    required this.color,
  });

  final double left, top, size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: size,
        height: size * 1.01,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(blurRadius: 400, color: color.withOpacity(0.7))
          ],
        ),
      ),
    );
  }
}
