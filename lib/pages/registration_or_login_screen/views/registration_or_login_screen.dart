import 'package:atlas_mobile/pages/registration_or_login_screen/controller/registration_or_login_screen_controller.dart';
import 'package:atlas_mobile/pages/registration_or_login_screen/views/large_button.dart';
import 'package:atlas_mobile/pages/registration_or_login_screen/views/logo_stripes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RegistrationOrLoginScreen extends StatelessWidget {
  const RegistrationOrLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegistrationOrLoginScreenController c =
        Get.put(RegistrationOrLoginScreenController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const LogoStripes(),
            Container(
              margin: EdgeInsets.only(top: c.width * 0.1),
              child: SvgPicture.asset(
                'assets/images/logo.svg',
                semanticsLabel: 'Atlas Logo',
                width: c.width * 0.3,
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: c.width * 0.075, bottom: c.width * 0.05),
              child: const Text(
                'atlas.',
                style: TextStyle(
                  fontSize: 37,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Text(
              'What\'s your story?',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: c.height * 0.125),
            LargeButton(
              c: c,
              color: const Color(0xFFEFCB68),
              displayText: 'Register',
              displayTextColor: Colors.black,
              onPressed: () {
                c.sendToRegistrationScreen();
              },
            ),
            SizedBox(height: c.height * 0.025),
            LargeButton(
              c: c,
              color: const Color(0xFF182335),
              displayText: 'Login',
              displayTextColor: Colors.white,
              onPressed: () {
                c.sendToLoginScreen();
              },
            ),
          ],
        ),
      ),
    );
  }
}
