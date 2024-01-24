import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:dimipay_pos_flutter/app/routes/pages.dart';
import 'package:dimipay_pos_flutter/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

String getInintialRoute({bool debug = false}) {
  return Routes.pin;
  // return debug ? Routes.test : Routes.home;
}

void main() async {
  // await AppLoader().load();
  runApp(GetMaterialApp(
    title: '디미페이 POS',
    getPages: AppPages.pages,
    theme: ThemeData(
      fontFamily: 'SUITv1',
      primaryColor: DPColors.primaryBrand,
      scaffoldBackgroundColor: DPColors.grayscale100,
    ),
    initialRoute: getInintialRoute(debug: true),
    debugShowCheckedModeBanner: false,
  ));
}
