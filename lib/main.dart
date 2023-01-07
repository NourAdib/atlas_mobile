import 'package:atlas_mobile/pages/login_screen/views/login_screen.dart';
import 'package:atlas_mobile/pages/registration_or_login_screen/views/registration_or_login_screen.dart';
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
          GetPage(name: '/splash', page: () => const SplashScreen()),
          GetPage(
            name: '/registrationOrLogin',
            page: () => const RegistrationOrLoginScreen(),
            transition: Transition.zoom,
          ),
          /* GetPage(
            name: '/registration',
            page: () => const RegistrationScreen(),
            transition: Transition.zoom,
          ),
          */
          GetPage(
            name: '/login',
            page: () => const LoginScreen(),
            transition: Transition.leftToRight,
          ),
        ],
      ),
    );
