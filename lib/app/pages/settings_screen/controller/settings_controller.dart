import 'dart:developer';

import 'package:atlas_mobile/app/pages/settings_screen/views/FAQs/faqs_screen.dart';
import 'package:atlas_mobile/app/pages/settings_screen/views/account_settings/account_settings.dart';
import 'package:atlas_mobile/app/pages/settings_screen/views/contact_us/contact_us_screen.dart';
import 'package:atlas_mobile/app/pages/settings_screen/views/notificaions/notification_screen.dart';
import 'package:atlas_mobile/app/pages/settings_screen/views/privacy_screen.dart';
import 'package:atlas_mobile/app/pages/settings_screen/views/security/security_screen.dart';
import 'package:atlas_mobile/app/pages/settings_screen/views/subscription/subscription_screen.dart';
import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

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
    Get.to(() => const AccountSettings());
  }

  goToSecuritySettings() {
    Get.to(() => const SecurityScreen());
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
    Get.to(() => const ContactUsScreen());
  }

  goToSubscriptionSettings() {
    Get.to(() => const SubscriptionScreen());
  }

  launchURL(String uri) async {
    if (!await launchUrl(Uri.parse(uri))) {
      throw Exception('Could not launch $uri');
    }
  }
}
