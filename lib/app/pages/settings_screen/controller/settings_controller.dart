import 'dart:developer';

import 'package:atlas_mobile/app/pages/settings_screen/views/FAQs/faqs_screen.dart';
import 'package:atlas_mobile/app/pages/settings_screen/views/notificaions/notification_screen.dart';
import 'package:atlas_mobile/app/pages/settings_screen/views/privacy_screen.dart';
import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  //Get the width of the screen
  var width = Get.width;

  //Get the height of the screen
  var height = Get.height;

  logout() {
    SharedPreferencesService.setInShared('accessToken', '');
    SnackBarService.showSuccessSnackbar('Success', 'Logout successful');
    Get.offNamed('/registrationOrLogin');
  }

  goToAccountSettings() {
    log('account settings');
  }

  goToSecuritySettings() {
    log('security settings');
  }

  goToPrivacySettings() {
    Get.to(() => const PrivacyScreen());
  }

  goToNotificationSettings() {
    Get.to(() => const NotificationSettingsScreen());
  }

  goToFAQs() {
    Get.to(() => const FAQsScreen());
  }

  goToContactUs() {
    log('contact us');
  }

  goToSubscriptionSettings() {
    log('subscription settings');
  }

  test() {
    log('test');
  }
}
