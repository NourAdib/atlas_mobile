import 'dart:developer';

import 'package:atlas_mobile/app/pages/profile_screen/controller/profile_screen_controller.dart';
import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'post_preview.dart';
import 'user_details.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.find<NavigationController>();

    final ProfileScreenController c = Get.put(ProfileScreenController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => Navbar(
          currentIndex: navigationController.selectedIndex.value,
          onItemTap: navigationController.onItemTap,
        ),
      ),
      appBar: const TopBar(pageTile: 'Profile'),
      body: SafeArea(
          child: Obx(
        () => c.isLoading.value
            ? const LoadingIndicator()
            : Column(
                children: [
                  UserDetails(
                    user: c.user,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          log("1");
                        },
                        child: Container(
                          height: Get.height * 0.06,
                          width: Get.width * 0.22,
                          decoration: BoxDecoration(
                            color: const Color(0xffFFF6E9),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 3),

                            // color: isThisOneSelected
                            //   ? Color(0xffEF694D)
                            // : Color(0xffFFF6E9),
                          ),
                          child:
                              SvgPicture.asset('assets/images/scraps_icon.svg'),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          log("2");
                        },
                        child: Container(
                          height: Get.height * 0.06,
                          width: Get.width * 0.22,
                          decoration: BoxDecoration(
                            color: Color(0xffFFF6E9),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 3),
                            // color: isThisOneSelected
                            //   ? Color(0xffEF694D)
                            // : Color(0xffFFF6E9),
                          ),
                          child: SvgPicture.asset(
                              'assets/images/memories_icon.svg'),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          log("3");
                        },
                        child: Container(
                          height: Get.height * 0.06,
                          width: Get.width * 0.22,
                          decoration: BoxDecoration(
                            color: Color(0xffFFF6E9),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 3),
                            // color: isThisOneSelected
                            //   ? Color(0xffEF694D)
                            // : Color(0xffFFF6E9),
                          ),
                          child: SvgPicture.asset(
                              'assets/images/scrapbooks_icon.svg'),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          log("4");
                        },
                        child: Container(
                          height: Get.height * 0.06,
                          width: Get.width * 0.22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffFFF6E9),
                            border: Border.all(color: Colors.black, width: 3),
                            // color: isThisOneSelected
                            //   ? Color(0xffEF694D)
                            // : Color(0xffFFF6E9),
                          ),
                          child:
                              SvgPicture.asset('assets/images/events_icon.svg'),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: 20,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemBuilder: ((context, index) {
                        return PostPreview();
                      }),
                    ),
                  ),
                ],
              ),
      )),
    );
  }
}
