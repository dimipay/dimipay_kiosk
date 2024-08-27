import 'package:dimipay_design_kit/interfaces/dimipay_colors.dart';
import 'package:dimipay_design_kit/interfaces/dimipay_typography.dart';
import 'package:dimipay_kiosk/app/pages/onboard/controller.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:dimipay_kiosk/app/widgets/barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OnboardingPage extends GetView<OnboardPageController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return BarcodeScanner(
      onKey: (input) async {
        Get.offAndToNamed(Routes.PRODUCT, arguments: input);
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox.expand(
            child: Column(
              children: [
                const Spacer(),
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/dimipay_logo.svg',
                      width: 346,
                      height: 72,
                    ),
                    const SizedBox(height: 64),
                    Text(
                      '매점에 오신 것을 환영합니다!',
                      style: textTheme.title
                          .copyWith(color: colorTheme.grayscale1000),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '물건의 바코드를 스캔하여 결제를 시작해주세요',
                      style: textTheme.header2
                          .copyWith(color: colorTheme.grayscale700),
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  child: Obx(
                    () => controller.healthAreaStatus.value.when(
                      loading: () => const HealthAreaLoading(),
                      success: () => const HealthAreaSuccess(),
                      failed: () => const HealthAreaFailed(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HealthAreaLoading extends StatelessWidget {
  const HealthAreaLoading({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Row(
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(colorTheme.grayscale500),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '서버 연결 확인 중...',
          style: textTheme.description.copyWith(color: colorTheme.grayscale500),
        ),
      ],
    );
  }
}

class HealthAreaFailed extends StatelessWidget {
  const HealthAreaFailed({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Row(
      children: [
        Icon(
          Icons.dns_outlined,
          color: colorTheme.primaryNegative,
          size: 20,
        ),
        const SizedBox(width: 6),
        Text(
          '서버 연결 실패',
          style:
              textTheme.description.copyWith(color: colorTheme.primaryNegative),
        ),
      ],
    );
  }
}

class HealthAreaSuccess extends GetView<OnboardPageController> {
  const HealthAreaSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Row(
      children: [
        Icon(
          Icons.dns_outlined,
          color: colorTheme.grayscale500,
          size: 20,
        ),
        const SizedBox(width: 6),
        Text(
          '서버 연결 완료',
          style: textTheme.description.copyWith(color: colorTheme.grayscale500),
        ),
        const SizedBox(width: 16),
        Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: colorTheme.grayscale500,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        const SizedBox(width: 16),
        Icon(
          Icons.monitor_outlined,
          color: colorTheme.grayscale500,
          size: 20,
        ),
        const SizedBox(width: 6),
        Text(
          controller.authService.name!,
          style: textTheme.description.copyWith(color: colorTheme.grayscale500),
        ),
        const SizedBox(width: 16),
        Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: colorTheme.grayscale500,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        const SizedBox(width: 16),
        Icon(
          Icons.school_outlined,
          color: colorTheme.grayscale500,
          size: 20,
        ),
        const SizedBox(width: 6),
        Text(
          '한국디지털미디어고등학교',
          style: textTheme.description.copyWith(color: colorTheme.grayscale500),
        ),
      ],
    );
  }
}
