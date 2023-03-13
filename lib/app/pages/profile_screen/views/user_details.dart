import 'dart:developer';

import 'package:atlas_mobile/app/model/enums/subscription.enum.dart';
import 'package:atlas_mobile/app/model/user.model.dart';
import 'package:atlas_mobile/app/pages/edit_profile_screen/views/edit_profile_screen.dart';
import 'package:atlas_mobile/app/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class UserDetails extends StatelessWidget {
  final User user;
  final bool isLocked;
  final bool sentFollowRequest;
  final bool isLoggedInUser;
  final String followRequestStatus;
  final Function()? onLockTap;
  final Function()? moreUserOptionsTap;
  const UserDetails({
    required this.user,
    this.isLocked = false,
    this.sentFollowRequest = false,
    this.isLoggedInUser = true,
    this.followRequestStatus = '',
    this.onLockTap,
    this.moreUserOptionsTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.22,
      width: Get.width * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 3),
        color: const Color(0xffFFF6E9),
      ),
      child: Row(
        children: [
          SizedBox(
            width: Get.width * 0.228,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  user.username ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                UserAvatar(
                  height: Get.height * 0.1,
                  width: Get.height * 0.1,
                  profilePictureUrl: user.profilePictureUrl ?? '',
                  minRadius: 35,
                ),
                Container(
                  height: Get.height * 0.026,
                  width: Get.width * 0.2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xffEFCB68),
                  ),
                  child: Text(
                    user.role.toString().split('.').last.capitalizeFirst ?? '',
                    style: const TextStyle(fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
            width: Get.width * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                isLocked
                    ? InkWell(
                        onTap: () {
                          onLockTap!();
                        },
                        child: Container(
                          width: Get.width * 0.22,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xffEF694D),
                            border: Border.all(
                              color: Colors.black,
                              width: 3,
                            ),
                          ),
                          child: sentFollowRequest
                              ? Text(
                                  followRequestStatus.capitalizeFirst ?? '',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Follow',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      )
                    : Text(
                        "${user.firstName ?? ''} ${user.lastName ?? ''} ${user.subscriptionPlan == SubscriptionPlan.Premium ? '👑' : ''}"),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(user.followersCount.toString()),
                            const Text(
                              "Followers",
                              style: TextStyle(
                                color: Color(0xFFEE5959),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(user.followingCount.toString()),
                            const Text(
                              "Following",
                              style: TextStyle(
                                color: Color(0xFFEE5959),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: const Text(
                        "Bio",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFEE5959),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.04,
                      child: Text(
                        user.bio ?? '',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          !isLoggedInUser
              ? InkWell(
                  onTap: () {
                    moreUserOptionsTap!();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xffEF694D),
                            radius: Get.height * 0.02,
                            child: SvgPicture.asset(
                              width: Get.width * 0.07,
                              'assets/images/report_user_icon.svg',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    Get.to(() => const EditProfileScreen());
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xffEF694D),
                            radius: Get.height * 0.02,
                            child: SvgPicture.asset(
                              width: Get.width * 0.07,
                              'assets/images/edit_icon.svg',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
