import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/pages/payment/controller.dart';
import 'package:dimipay_kiosk/app/widgets/barcode_scanner.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:dimipay_kiosk/app/services/qr/service.dart';

class BackgroundSpot extends StatelessWidget {
  const BackgroundSpot({super.key, required this.size, required this.color});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size * 1.01,
      decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(blurRadius: 400, color: color.withOpacity(0.7))]),
    );
  }
}

class PaymentPage extends GetView<PaymentPageController> {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BarcodeScanner(
      onKey: (input) async => await QRService.to.approvePayment(input),
      child: Scaffold(
        body: SizedBox.expand(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("디미페이 앱의 결제 QR를 스캔해주세요", style: DPTypography.title(color: DPColors.grayscale1000)),
                    const SizedBox(height: 48),
                    Text("상품 스캔 창에서 결제 QR를 바로 스캔하면\n빠르게 결제를 완료할 수 있습니다", textAlign: TextAlign.center, style: DPTypography.header2(color: DPColors.grayscale600)),
                    const SizedBox(height: 64),
                    Container(
                      width: 420,
                      height: 8,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(color: DPColors.grayscale600.withOpacity(0.3), borderRadius: BorderRadius.circular(8)),
                      child: Obx(
                        () => AnimatedContainer(
                          width: 420.0 - 14 * (30 - PaymentPageController.to.timer),
                          height: 8,
                          duration: const Duration(seconds: 1),
                          decoration: BoxDecoration(color: DPColors.grayscale900.withOpacity(0.3), borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => Text(
                        "${PaymentPageController.to.timer}초",
                        style: DPTypography.header2(color: DPColors.grayscale600),
                      ),
                    ),
                    const SizedBox(height: 132),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => Get.back(),
                      onTapDown: (_) => PaymentPageController.to.pressedButton = "back",
                      onTapCancel: () => PaymentPageController.to.pressedButton = "",
                      onTapUp: (_) => () {
                        PaymentPageController.to.pressedButton = "";
                        Get.back();
                      },
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DPIcons(Symbols.arrow_back_ios_new, size: 24, color: PaymentPageController.to.pressedButton == "back" ? DPColors.grayscale600.withOpacity(0.5) : DPColors.grayscale600),
                            const SizedBox(width: 24),
                            Text("상품 스캔 화면으로 돌아가기",
                                style: DPTypography.header2(color: PaymentPageController.to.pressedButton == "back" ? DPColors.grayscale600.withOpacity(0.5) : DPColors.grayscale600)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Stack(
                children: [
                  Positioned(left: 723.54, top: 25.41 - 169.4, child: BackgroundSpot(size: 169.14, color: Color(0xFFFF0000))),
                  Positioned(left: 693.37, top: 1023.09 - 169.14, child: BackgroundSpot(size: 169.14, color: Color(0xFFFF0000))),
                  Positioned(left: 759.52, top: 725.2 - 249.12, child: BackgroundSpot(size: 249.12, color: Color(0xFF00C2FF))),
                  Positioned(left: 544.77, top: 425.58 - 249.12, child: BackgroundSpot(size: 249.12, color: Color(0xFF00C2FF))),
                  Positioned(left: 778.22, top: 316.23 - 249.12, child: BackgroundSpot(size: 249.12, color: Color(0xFF00FF7A))),
                  Positioned(left: 361.67, top: 23.19, child: BackgroundSpot(size: 250.96, color: Color(0xFF4200FF))),
                  Positioned(left: 378.67 - 328, top: 798.71, child: BackgroundSpot(size: 328.0, color: Color(0xFFFF7A00))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
