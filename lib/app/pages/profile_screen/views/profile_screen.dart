import 'dart:math';

import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.find<NavigationController>();
    return Scaffold(
      bottomNavigationBar: Obx(
        () => Navbar(
          currentIndex: navigationController.selectedIndex.value,
          onItemTap: navigationController.onItemTap,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: Get.height * 0.22,
                  width: Get.width * 0.95,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 3),
                    color: const Color(0xffFFF6E9),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("@user"),
                          CircleAvatar(
                            radius: Get.height * 0.042,
                            backgroundColor: Colors.black,
                          ),
                          Container(
                            height: Get.height * 0.026,
                            width: Get.width * 0.186,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xffEFCB68)),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("name"),
                          Row(
                            children: const [
                              Text("followers"),
                              Text("following"),
                            ],
                          ),
                          const Text("Bio"),
                        ],
                      ),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: Get.height * 0.025,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: Get.height * 0.06,
                  width: Get.width * 0.22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 3),
                    color: Color(0xffFFF6E9),
                  ),
                ),
                Container(
                  height: Get.height * 0.06,
                  width: Get.width * 0.22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 3),
                    color: Color(0xffFFF6E9),
                  ),
                ),
                Container(
                  height: Get.height * 0.06,
                  width: Get.width * 0.22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 3),
                    color: Color(0xffFFF6E9),
                  ),
                ),
                Container(
                  height: Get.height * 0.06,
                  width: Get.width * 0.22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 3),
                    color: Color(0xffFFF6E9),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
