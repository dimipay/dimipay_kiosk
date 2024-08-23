import 'package:dimipay_kiosk/app/core/theme/light.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/core/utils/loader.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:dimipay_kiosk/app/routes/pages.dart';

String getInintialRoute({bool debug = false}) {
  return debug ? Routes.TEST : Routes.ONBOARDING;
}

void main() async {
  await AppLoader().load();
  runApp(
    GetMaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data:
              MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: child!,
        );
      },
      title: '디미페이 키오스크',
      initialRoute: getInintialRoute(debug: false),
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      themeMode: ThemeMode.light,
    ),
  );
}
