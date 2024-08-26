import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  Widget linkToRoute(String route) {
    return TextButton(
      onPressed: () {
        Get.toNamed(route);
      },
      child: Text(route),
    );
  }

  Widget linkToRouteWithArgs(
      String route, String title, Map<String, dynamic> args) {
    return TextButton(
      onPressed: () {
        Get.toNamed(route, arguments: args);
      },
      child: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Route Test Page"),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          linkToRoute(Routes.ONBOARDING),
          linkToRoute(Routes.PIN),
          linkToRoute(Routes.PRODUCT),
          linkToRoute(Routes.PAYMENT),
          linkToRoute(Routes.PAYMENT_PENDING),
          linkToRoute(Routes.PAYMENT_SUCCESS),
          linkToRoute(Routes.PAYMENT_FAILED),
        ],
      ),
    );
  }
}
