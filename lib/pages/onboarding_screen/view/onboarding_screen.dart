import 'dart:developer';

import 'package:atlas_mobile/pages/onboarding_screen/controller/onboarding_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OnboardingController c = Get.put(OnboardingController());
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          globalBackgroundColor: Colors.white,
          allowImplicitScrolling: true,
          isTopSafeArea: true,
          dotsDecorator: const DotsDecorator(
            activeColor: Color(0xFF182335),
            color: Color(0xFFD9D9D9),
          ),
          pages: [
            PageViewModel(
              title: "Capture Your Memories",
              body:
                  "Capture your memories and relive them whenever you revisit your favorite locations.",
              image: Image.asset(
                'assets/images/onboarding_1.png',
              ),
              decoration: const PageDecoration(
                imageFlex: 2,
                imagePadding: EdgeInsets.all(8.0),
              ),
            ),
            PageViewModel(
              title: "Engage in Community Events",
              body: "Take part in treasure hunts, meetups, and more.",
              image: Image.asset(
                'assets/images/onboarding_2.png',
              ),
              decoration: const PageDecoration(
                imageFlex: 2,
                imagePadding: EdgeInsets.all(8.0),
              ),
            ),
            PageViewModel(
              title: "Share Your Story With Others",
              body:
                  "Relive memories with your friends and share them with others",
              image: Image.asset(
                'assets/images/onboarding_3.png',
              ),
              decoration: const PageDecoration(
                imageFlex: 2,
                imagePadding: EdgeInsets.all(8.0),
              ),
            ),
          ],
          onDone: () => c.done(),
          skip: const Text(
            'Skip',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          back: const Text(
            "Previous",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          next: const Text(
            "Next",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          done: const Text(
            "Done",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          showBackButton: true,
          backStyle: TextButton.styleFrom(
            backgroundColor: const Color(0xFFEFCB68),
            minimumSize: Size(c.width * 0.3, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          nextStyle: TextButton.styleFrom(
            backgroundColor: const Color(0xFF182335),
            minimumSize: Size(c.width * 0.3, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          doneStyle: TextButton.styleFrom(
            backgroundColor: const Color(0xFF182335),
            minimumSize: Size(c.width * 0.3, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}
