import 'dart:math';

import 'package:atlas_mobile/app/pages/settings_screen/controller/settings_controller.dart';
import 'package:atlas_mobile/app/pages/settings_screen/views/settings_option.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main/controller/navigation_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.put(NavigationController());

    final SettingsController c = Get.put(SettingsController());

    return Scaffold(
      appBar: const TopBar(
        pageTile: 'Settings',
        hasBackButton: true,
      ),
      bottomNavigationBar: Obx(
        () => Navbar(
          currentIndex: navigationController.selectedIndex.value,
          onItemTap: navigationController.onItemTap,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SettingsOption(
                  title: 'Account Settings', onTap: c.goToAccountSettings),
              SettingsOption(title: 'Security', onTap: c.goToSecuritySettings),
              SettingsOption(title: 'Privacy', onTap: c.goToPrivacySettings),
              SettingsOption(
                  title: 'Notification Settings',
                  onTap: c.goToNotificationSettings),
              SettingsOption(
                  title: 'Follow Requests', onTap: c.goToFollowRequests),
              SettingsOption(title: 'FAQs', onTap: c.goToFAQs),
              SettingsOption(title: 'Contact Us', onTap: c.goToContactUs),
              SettingsOption(
                  title: 'Subscription', onTap: c.goToSubscriptionSettings),
              SettingsOption(title: 'Logout', onTap: c.logout),
            ],
          ),
        ),
      ),
    );
  }
}
