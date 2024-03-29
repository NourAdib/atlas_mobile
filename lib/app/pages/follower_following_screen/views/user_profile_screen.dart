import 'package:atlas_mobile/app/model/user.model.dart';
import 'package:atlas_mobile/app/pages/follower_following_screen/controller/user_profile_controller.dart';
import 'package:atlas_mobile/app/pages/profile_screen/views/post_preview.dart';
import 'package:atlas_mobile/app/pages/profile_screen/views/scrapbook_preview.dart';
import 'package:atlas_mobile/app/pages/profile_screen/views/user_details.dart';
import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserProfileScreen extends StatelessWidget {
  final User user;
  const UserProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.find<NavigationController>();

    final UserProfileScreenController c =
        Get.put(UserProfileScreenController(visitedUser: user));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.setVisitedUser(user);
      c.loadData();
    });

    return Scaffold(
      bottomNavigationBar: Obx(
        () => Navbar(
          currentIndex: navigationController.selectedIndex.value,
          onItemTap: navigationController.onItemTap,
        ),
      ),
      appBar: TopBar(pageTile: '${c.visitedUser.username}\'s Profile'),
      body: SafeArea(
          child: Obx(
        () => c.isLoading.value
            ? const LoadingIndicator()
            : Column(
                children: [
                  UserDetails(
                    user: c.visitedUser,
                    isLoggedInUser: false,
                    isLocked: !c.isFollowing.value,
                    sentFollowRequest: c.sentFollowRequest.value,
                    followRequestStatus: c.followRequestStatus.value,
                    onLockTap: c.followUser,
                    moreUserOptionsTap: c.moreUserOptionsTap,
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
                  !c.isFollowing.value
                      ? Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/images/lock_icon.svg'),
                              const Text(
                                'Follow to view posts',
                                style: TextStyle(
                                  color: Color(0xFFEF694D),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  c.isDisplayingPosts.value &&
                          c.isFollowing.value &&
                          c.postsList.isNotEmpty
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
                  c.isDisplayingScrapbooks.value &&
                          c.isFollowing.value &&
                          c.scrapbooksList.isNotEmpty
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
                ],
              ),
      )),
    );
  }
}
