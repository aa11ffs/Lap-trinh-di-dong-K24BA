import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/modules/splash/controllers/splash_controller.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/widgets/custom_logo.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashController = Get.find<SplashController>();
  @override
  void initState() {
    super.initState();
    splashController.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: splashController.logoTag,
              child: const CustomLogo(
                width: 60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
