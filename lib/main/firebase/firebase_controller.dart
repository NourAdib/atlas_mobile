import 'dart:developer';

import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
import 'package:atlas_mobile/main/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FirebaseController extends GetxController {
  initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await initFCM();
  }

  initFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    final fcmToken = await messaging.getToken();
    SharedPreferencesService.setInShared('fcmToken', fcmToken.toString());

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String title = message.notification?.title ?? '';
      String body = message.notification?.body ?? '';

      SnackBarService.showNotificationSnackbar(title, body);

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification?.title}');
      }
    });
    log('FCM Token $fcmToken');
  }
}
