import 'package:dimipay_kiosk/app/services/kiosk/repository.dart';
import 'package:get/get.dart';

class KioskService extends GetxController {
  final KioskRepository repository;

  KioskService({KioskRepository? repository})
      : repository = repository ?? KioskRepository();

  final Rx<String?> _health = Rx(null);

  String? get health => _health.value;

  Future<String> getHealth() async {
    try {
      Map data = await repository.getHealth();
      _health.value = data["status"];
      return _health.value!;
    } catch (e) {
      rethrow;
    }
  }
}
