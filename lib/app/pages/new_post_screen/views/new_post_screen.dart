import 'dart:developer';

import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../widgets/topBar/topbar.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.find<NavigationController>();
    return Scaffold(
      appBar: const TopBar(
        pageTile: 'Create',
      ),
      bottomNavigationBar: Obx(
        () => Navbar(
          currentIndex: navigationController.selectedIndex.value,
          onItemTap: navigationController.onItemTap,
        ),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  log("Scraps");
                },
                child: Container(
                  width: Get.width * 0.94,
                  height: Get.height * 0.18,
                  decoration: BoxDecoration(
                    color: Color(0xffFFF6E9),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                          width: Get.width * 0.2,
                          color: Colors.black,
                          'assets/images/scraps_icon.svg'),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(style: TextStyle(fontSize: 25), "Scraps"),
                          Text("create a new post and"),
                          Text("preserve your photos"),
                          Text("and memorobila forever"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  log("memories");
                },
                child: Container(
                  width: Get.width * 0.94,
                  height: Get.height * 0.18,
                  decoration: BoxDecoration(
                    color: Color(0xffFFF6E9),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                          width: Get.width * 0.2,
                          color: Colors.black,
                          'assets/images/memories_icon.svg'),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(style: TextStyle(fontSize: 25), "Memories"),
                          Text("create a new memorie"),
                          Text("to share your special"),
                          Text("moment with the world"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  log("scrapbook");
                },
                child: Container(
                  width: Get.width * 0.94,
                  height: Get.height * 0.18,
                  decoration: BoxDecoration(
                    color: Color(0xffFFF6E9),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                          width: Get.width * 0.2,
                          color: Colors.black,
                          'assets/images/scrapbooks_icon.svg'),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(style: TextStyle(fontSize: 25), "Scrapbooks"),
                          Text("create a new scrapbook"),
                          Text("to make your own"),
                          Text("post bound scrapbook"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  log("event");
                },
                child: Container(
                  width: Get.width * 0.94,
                  height: Get.height * 0.18,
                  decoration: BoxDecoration(
                    color: Color(0xffFFF6E9),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                          width: Get.width * 0.2,
                          color: Colors.black,
                          'assets/images/events_icon.svg'),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(style: TextStyle(fontSize: 25), "Events"),
                          Text("create a new event"),
                          Text("to challange your"),
                          Text("friends in a competition"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
