import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SplashScreenController c = Get.put(SplashScreenController());

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SvgPicture.asset(
              'assets/images/logo.svg',
              semanticsLabel: 'Atlas Logo',
              width: c.width * 0.5,
          ),
        ),
      ),
    );
  }
}
