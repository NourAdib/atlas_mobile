import 'package:atlas_mobile/app/pages/maps_screen/views/ar_screen.dart';
import 'package:atlas_mobile/app/pages/maps_screen/views/switch_button.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MapsScreenScreen extends StatelessWidget {
  const MapsScreenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.find<NavigationController>();

    return Scaffold(
      appBar: const TopBar(
        pageTile: 'Map',
      ),
      bottomNavigationBar: Obx(
        () => Navbar(
          currentIndex: navigationController.selectedIndex.value,
          onItemTap: navigationController.onItemTap,
        ),
      ),
      body: SafeArea(
        child: Column(children: [
          const Text('Map'),
          CircleButton(
              onPressed: () {
                Get.toNamed('/ar');
              },
              size: 50.0,
              color: const Color(0xFFEFCB68),
              borderColor: const Color(0xFF182335),
              icon: "assets/images/camera_icon.svg",
              iconSize: 35,
              iconColor: const Color(0xFF182335))
        ]),
      ),
    );
  }
}
