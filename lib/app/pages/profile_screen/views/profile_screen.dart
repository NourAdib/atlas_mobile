import 'dart:developer';

import 'package:atlas_mobile/app/pages/profile_screen/controller/profile_screen_controller.dart';
import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'event_preview.dart';
import 'memory_preview.dart';
import 'post_preview.dart';
import 'scrapbook_preview.dart';
import 'user_details.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.find<NavigationController>();

    final ProfileScreenController c = Get.put(ProfileScreenController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.loadData();
    });

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
                          c.displayUserPosts();
                        },
                        child: Container(
                          height: Get.height * 0.06,
                          width: Get.width * 0.22,
                          decoration: BoxDecoration(
                            color: c.isDisplayingPosts.value
                                ? const Color(0xffEF694D)
                                : const Color(0xffFFF6E9),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 3),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/scraps_icon.svg',
                            color: c.isDisplayingPosts.value
                                ? const Color(0xffffffff)
                                : const Color(0xff000000),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          c.displayUserMemories();
                        },
                        child: Container(
                          height: Get.height * 0.06,
                          width: Get.width * 0.22,
                          decoration: BoxDecoration(
                            color: c.isDisplayingMemories.value
                                ? const Color(0xffEF694D)
                                : const Color(0xffFFF6E9),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 3),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/memories_icon.svg',
                            color: c.isDisplayingMemories.value
                                ? const Color(0xffffffff)
                                : const Color(0xff000000),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          c.displayUserScrapbooks();
                        },
                        child: Container(
                          height: Get.height * 0.06,
                          width: Get.width * 0.22,
                          decoration: BoxDecoration(
                            color: c.isDisplayingScrapbooks.value
                                ? const Color(0xffEF694D)
                                : const Color(0xffFFF6E9),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 3),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/scrapbooks_icon.svg',
                            color: c.isDisplayingScrapbooks.value
                                ? const Color(0xffffffff)
                                : const Color(0xff000000),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          c.displayUserEvents();
                        },
                        child: Container(
                          height: Get.height * 0.06,
                          width: Get.width * 0.22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: c.isDisplayingEvents.value
                                ? const Color(0xffEF694D)
                                : const Color(0xffFFF6E9),
                            border: Border.all(color: Colors.black, width: 3),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/events_icon.svg',
                            color: c.isDisplayingEvents.value
                                ? const Color(0xffffffff)
                                : const Color(0xff000000),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  c.isDisplayingPosts.value
                      ? Expanded(
                          child: GridView.builder(
                            itemCount: c.postsList.length,
                            controller: c.postsScrollController,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                            ),
                            padding: const EdgeInsets.all(10),
                            itemBuilder: ((context, index) {
                              return PostPreview(
                                post: c.postsList[index],
                              );
                            }),
                          ),
                        )
                      : const SizedBox(),
                  c.isDisplayingMemories.value
                      ? Expanded(
                          child: GridView.builder(
                            itemCount: c.memoriesList.length,
                            controller: c.memoriesScrollController,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                            ),
                            padding: const EdgeInsets.all(10),
                            itemBuilder: ((context, index) {
                              return MemoryPreview(
                                memory: c.memoriesList[index],
                              );
                            }),
                          ),
                        )
                      : const SizedBox(),
                  c.isDisplayingScrapbooks.value
                      ? Expanded(
                          child: GridView.builder(
                            itemCount: c.scrapbooksList.length,
                            controller: c.scrapbookScrollController,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                            ),
                            padding: const EdgeInsets.all(10),
                            itemBuilder: ((context, index) {
                              return ScrapbookPreview(
                                scrapbook: c.scrapbooksList[index],
                              );
                            }),
                          ),
                        )
                      : const SizedBox(),
                  c.isDisplayingEvents.value
                      ? Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 7,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFF6E9),
                                          border: Border.all(
                                            color: const Color(0xFF182335),
                                            width: 3,
                                            style: BorderStyle.solid,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.25),
                                              blurRadius: 4,
                                              offset: Offset(0,
                                                  4), // changes position of shadow
                                            )
                                          ],
                                        ),
                                        child: const Text(
                                          'Show Joined Event',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Switch(
                                          value: c.isJoinedEventsSelected.value,
                                          activeColor: const Color(0xffEF694D),
                                          onChanged: (_) {
                                            c.toggleJoinedEventsSelected();
                                          }),
                                    ],
                                  ),
                                ),
                                c.isJoinedEventsSelected.value
                                    ? ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: c.joinedEventsList.length,
                                        controller:
                                            c.joinedEventsScrollController,
                                        padding: const EdgeInsets.all(10),
                                        itemBuilder: ((context, index) {
                                          return EventPreview(
                                            event: c.joinedEventsList[index],
                                          );
                                        }),
                                      )
                                    : ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: c.eventsList.length,
                                        controller: c.eventsScrollController,
                                        padding: const EdgeInsets.all(10),
                                        itemBuilder: ((context, index) {
                                          return EventPreview(
                                            event: c.eventsList[index],
                                          );
                                        }),
                                      ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
      )),
    );
  }
}
