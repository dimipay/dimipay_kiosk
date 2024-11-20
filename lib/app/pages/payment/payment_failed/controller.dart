import 'package:dimipay_kiosk/app/services/timer/service.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

class PaymentFailedPageController extends GetxController {
  TimerService timerService = Get.find<TimerService>();
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void onInit() {
    timerService.stopTimer();
    _playErrorSound();
    super.onInit();
  }

  Future<void> _playErrorSound() async {
    await audioPlayer.play(AssetSource('assets/audio/bell.mp3'));
  }

  @override
  void onClose() {
    timerService.startTimer();
    audioPlayer.dispose();
    super.onClose();
  }
}