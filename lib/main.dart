import 'package:atlas_mobile/pages/home_screen/views/home_screen.dart';
import 'package:atlas_mobile/pages/login_screen/views/login_screen.dart';
import 'package:atlas_mobile/pages/onboarding_screen/view/onboarding_screen.dart';
import 'package:atlas_mobile/pages/registration_or_login_screen/views/registration_or_login_screen.dart';
import 'package:atlas_mobile/pages/registration_screen/views/registration_screen.dart';
import 'package:atlas_mobile/pages/splash_screen/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(
      GetMaterialApp(
        title: 'Atlas',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/splash',
        getPages: [
          GetPage(
            name: '/onboarding',
            page: () => const OnboardingScreen(),
          ),
          GetPage(
            name: '/splash',
            page: () => const SplashScreen(),
          ),
          GetPage(
            name: '/registrationOrLogin',
            page: () => const RegistrationOrLoginScreen(),
            transition: Transition.zoom,
          ),
          GetPage(
            name: '/registration',
            page: () => const RegistrationScreen(),
            transition: Transition.rightToLeft,
          ),
          GetPage(
            name: '/login',
            page: () => const LoginScreen(),
            transition: Transition.rightToLeft,
          ),
          GetPage(
            name: '/home',
            page: () => const HomeScreen(),
            transition: Transition.zoom,
          ),
        ],
      ),
    );
