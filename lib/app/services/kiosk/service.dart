import 'package:dimipay_kiosk/app/services/kiosk/repository.dart';
import 'package:get/get.dart';

class KioskService extends GetxController {
  final KioskRepository repository;

  KioskService({KioskRepository? repository})
      : repository = repository ?? KioskRepository();

  final _status = Rx<String?>(null);

  String? get status => _status.value;

  Future<String> getHealth() async {
    try {
      final data = await repository.getHealth();
      return _status.value = data["status"];
    } catch (e) {
      rethrow;
    }
  }
}
