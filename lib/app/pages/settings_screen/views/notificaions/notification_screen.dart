import 'package:atlas_mobile/app/pages/settings_screen/controller/notification_settings_controller.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.put(NavigationController());

    final NotificationSettingsController c =
        Get.put(NotificationSettingsController());

    return Scaffold(
      appBar: const TopBar(
        pageTile: 'Notification',
        hasBackButton: true,
      ),
      bottomNavigationBar: Obx(
        () => Navbar(
          currentIndex: navigationController.selectedIndex.value,
          onItemTap: navigationController.onItemTap,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF6E9),
                border: Border.all(
                  color: const Color(0xFF182335),
                  width: 3,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    blurRadius: 4,
                    offset: Offset(0, 4), // changes position of shadow
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mute All',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Obx(
                    () => Switch(
                        value: c.isMuteAllSelected.value,
                        onChanged: (_) {
                          c.muteAll();
                        }),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF6E9),
                border: Border.all(
                  color: const Color(0xFF182335),
                  width: 3,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    blurRadius: 4,
                    offset: Offset(0, 4), // changes position of shadow
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mute Broadcast',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Obx(
                    () => Switch(
                        value: c.isMuteBroadcastSelected.value,
                        onChanged: (_) {
                          c.muteBroadcast();
                        }),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF6E9),
                border: Border.all(
                  color: const Color(0xFF182335),
                  width: 3,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    blurRadius: 4,
                    offset: Offset(0, 4), // changes position of shadow
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mute Selected Group',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Obx(
                    () => Switch(
                        value: c.isMuteGroupSelected.value,
                        onChanged: (_) {
                          c.muteSelectedGroup();
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
