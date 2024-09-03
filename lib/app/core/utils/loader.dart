import 'package:dimipay_kiosk/app/provider/api.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/services/theme/service.dart';
import 'package:dimipay_kiosk/app/services/timer/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

class AppLoader {
  Future<void> load() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    await Hive.initFlutter();

    Get.lazyPut<SecureApiProvider>(() => ProdSecureApiProvider());
    await Get.putAsync(AuthService().init);
    await Get.putAsync(ThemeService().init);

    Get.put(TimerService());

    await initializeDateFormatting('ko_KR');
  }
}
