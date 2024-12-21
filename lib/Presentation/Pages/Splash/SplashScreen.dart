import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Controllers/Splash/SplashController.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SplashController splashController = Get.find();
    splashController.check();

    return Scaffold(
      body: Center(
        child: Container(

        ),
      ),
    );
  }
}