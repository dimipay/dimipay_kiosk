import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/widgets/alert_modal.dart';
import 'package:dimipay_kiosk/app/routes/pages.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';

String getInintialRoute({bool debug = false}) {
  return Routes.PIN;
  // return debug ? Routes.test : Routes.home;
}

void main() async {
  Get.lazyPut(() => AlertModal());
  runApp(GetMaterialApp(
      title: '디미페이 POS',
      getPages: AppPages.pages,
      initialRoute: getInintialRoute(debug: true),
      theme: ThemeData(
          fontFamily: 'SUITv1',
          primaryColor: DPColors.primaryBrand,
          scaffoldBackgroundColor: DPColors.grayscale100),
      debugShowCheckedModeBanner: false));
}
