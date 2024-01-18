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
    initialRoute: getInintialRoute(debug: true),
    getPages: AppPages.pages,
    debugShowCheckedModeBanner: false,
  ));
}
