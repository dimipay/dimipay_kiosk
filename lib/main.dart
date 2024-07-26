import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/core/utils/loader.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:dimipay_kiosk/app/routes/pages.dart';

void main() async {
  await AppLoader().load();
  runApp(
    GetMaterialApp(
      title: '디미페이 키오스크',
      getPages: AppPages.pages,
      initialRoute:
          AuthService.to.isAuthenticated ? Routes.ONBOARD : Routes.PIN,
      theme: ThemeData(
          fontFamily: 'SUITv1',
          primaryColor: DPColors.primaryBrand,
          scaffoldBackgroundColor: DPColors.grayscale100),
      debugShowCheckedModeBanner: false,
    ),
  );
}
