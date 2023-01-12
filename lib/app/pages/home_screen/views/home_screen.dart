import 'package:atlas_mobile/app/pages/home_screen/controller/home_screen_controller.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeScreenController c = Get.put(HomeScreenController());
    final NavigationController navigationController =
        Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => Navbar(
          currentIndex: navigationController.selectedIndex.value,
          onItemTap: navigationController.onItemTap,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Text('Home Screen'),
              ElevatedButton(
                onPressed: () {
                  c.logout();
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
