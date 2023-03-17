import 'dart:developer';

import 'package:atlas_mobile/app/pages/home_screen/views/home_screen.dart';
import 'package:atlas_mobile/app/pages/login_screen/views/login_screen.dart';
import 'package:atlas_mobile/app/pages/maps_screen/views/ar_screen.dart';
import 'package:atlas_mobile/app/pages/maps_screen/views/maps_screen.dart';
import 'package:atlas_mobile/app/pages/new_post_screen/views/new_post_screen.dart';
import 'package:atlas_mobile/app/pages/new_post_screen/views/review_new_event.dart';
import 'package:atlas_mobile/app/pages/new_post_screen/views/review_new_memory.dart';
import 'package:atlas_mobile/app/pages/new_post_screen/views/review_new_scrap.dart';
import 'package:atlas_mobile/app/pages/onboarding_screen/view/onboarding_screen.dart';
import 'package:atlas_mobile/app/pages/profile_screen/views/profile_screen.dart';
import 'package:atlas_mobile/app/pages/registration_or_login_screen/views/registration_or_login_screen.dart';
import 'package:atlas_mobile/app/pages/registration_screen/views/registration_screen.dart';
import 'package:atlas_mobile/app/pages/settings_screen/views/settings_screen.dart';
import 'package:atlas_mobile/app/pages/splash_screen/views/splash_screen.dart';
import 'package:atlas_mobile/app/pages/user_search_screen/views/user_search_screen.dart';
import 'package:atlas_mobile/main/firebase/firebase_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/pages/new_post_screen/views/review_new_scrapbook.dart';

void main() async {
  final FirebaseController firebaseController = Get.put(FirebaseController());
  await firebaseController.initFirebase().then((value) {
    log('Firebase Initialized');
  });
  runApp(
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
          name: '/maps',
          page: () => const MapsScreen(),
        ),
        GetPage(name: '/ar', page: () => const ArScreen()),
        GetPage(
          name: '/new_post',
          page: () => const NewPostScreen(),
        ),
        GetPage(
          name: '/profile',
          page: () => const ProfileScreen(),
        ),
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
        ),
        GetPage(
          name: '/reviewScrap',
          page: () => const ReviewScrap(),
        ),
        GetPage(
          name: '/reviewMemory',
          page: () => const ReviewMemory(),
        ),
        GetPage(
          name: '/createEvent',
          page: () => const ReviewEvent(),
        ),
        GetPage(name: '/createScrapbook', page: () => const ReviewScarpbook()),
        GetPage(
          name: '/settings',
          page: () => const SettingsScreen(),
        ),
        GetPage(
          name: '/userSearch',
          page: () => const UserSearchScreen(),
        ),
      ],
    ),
  );
}
