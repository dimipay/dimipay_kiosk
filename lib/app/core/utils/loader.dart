import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/widgets/alert_modal.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/provider/api.dart';

class AppLoader {
  Future<void> load() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // await dotenv.load(fileName: "env/.env", isOptional: true);
    Get.lazyPut(() => AlertModal());
    Get.lazyPut<ApiProvider>(() => DevApiProvider());

    await Get.putAsync(() => AuthService().init());
  }
}
