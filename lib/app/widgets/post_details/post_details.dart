import 'package:atlas_mobile/app/pages/profile_screen/views/post_image.dart';
import 'package:atlas_mobile/app/widgets/post_details/post_details_controller.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/app/widgets/user_avatar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../model/post.model.dart';
import '../navbar.dart';
import 'comment_preview.dart';
import 'like_preview.dart';

class PostDetailsScreen extends StatelessWidget {
  final Post post;
  final double height;
  final double width;

  const PostDetailsScreen(
      {required this.post, required this.height, required this.width, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.put(NavigationController());

    final PostDetailsScreenController c =
        Get.put(PostDetailsScreenController());

/*     c.setOwnership(post.postedBy!.id!);
 */
    c.setPost(post);
    c.getUserProfile();

    return Scaffold(
      appBar: const TopBar(
        pageTile: 'Scrap',
        hasBackButton: true,
      ),
      bottomNavigationBar: Obx(
        () => Navbar(
          currentIndex: navigationController.selectedIndex.value,
          onItemTap: navigationController.onItemTap,
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF6E9),
                    border: Border.all(
                      color: const Color(0xFF182335),
                      width: 10,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        blurRadius: 4,
                        offset: Offset(0, 4), // changes position of shadow
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              UserAvatar(
                                profilePictureUrl:
                                    post.postedBy?.profilePictureUrl ?? '',
                                width: width * 0.1,
                                height: height * 0.1,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(post.postedBy!.username!),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF182335),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              post.tag!,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: width * 0.02,
                      ),
                      PostImage(
                        imageUrl: post.imageUrl!,
                        caption: post.caption!,
                        height: height * 0.4,
                      ),
                      SizedBox(
                        height: width * 0.02,
                      ),
                      SizedBox(
                        width: width,
                        child: Text(
                          post.caption!,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      !c.isOwner.value
                          ? InkWell(
                              onTap: () {
                                c.isLiked.value ? c.unlikePost() : c.likePost();
                              },
                              child: Container(
                                height: Get.height * 0.06,
                                width: Get.width * 0.22,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: c.isLiked.value
                                      ? const Color(0xffEF694D)
                                      : const Color(0xffFFF6E9),
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.black, width: 3),
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/like_icon.svg',
                                  color: c.isLiked.value
                                      ? const Color(0xffffffff)
                                      : const Color(0xff000000),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      c.isOwner.value
                          ? InkWell(
                              onTap: () {
                                c.displayLikes();
                              },
                              child: Container(
                                height: Get.height * 0.06,
                                width: Get.width * 0.22,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: c.isDisplayingLikes.value
                                      ? const Color(0xffEF694D)
                                      : const Color(0xffFFF6E9),
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.black, width: 3),
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/like_icon.svg',
                                  color: c.isDisplayingLikes.value
                                      ? const Color(0xffffffff)
                                      : const Color(0xff000000),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      InkWell(
                        onTap: () {
                          c.displayComments();
                        },
                        child: Container(
                          height: Get.height * 0.06,
                          width: Get.width * 0.22,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: c.isDisplayingComments.value
                                ? const Color(0xffEF694D)
                                : const Color(0xffFFF6E9),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 3),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/comment_icon.svg',
                            color: c.isDisplayingComments.value
                                ? const Color(0xffffffff)
                                : const Color(0xff000000),
                          ),
                        ),
                      ),
                      c.isOwner.value && c.isPremium.value
                          ? InkWell(
                              onTap: () {
                                c.displayAnalytics();
                              },
                              child: Container(
                                height: Get.height * 0.06,
                                width: Get.width * 0.22,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: c.isDisplayingAnalytics.value
                                      ? const Color(0xffEF694D)
                                      : const Color(0xffFFF6E9),
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.black, width: 3),
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/analytics_icon.svg',
                                  color: c.isDisplayingAnalytics.value
                                      ? const Color(0xffffffff)
                                      : const Color(0xff000000),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      InkWell(
                        onTap: () {
                          c.displayMoreOptions();
                        },
                        child: Container(
                          height: Get.height * 0.06,
                          width: Get.width * 0.22,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: c.isDisplayingMoreOptions.value
                                ? const Color(0xffEF694D)
                                : const Color(0xffFFF6E9),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 3),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/more_options_icon.svg',
                            color: c.isDisplayingMoreOptions.value
                                ? const Color(0xffffffff)
                                : const Color(0xff000000),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                c.isDisplayingLikes.value && c.post.likes!.isNotEmpty
                    ? Flexible(
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF6E9),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 3),
                          ),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: c.post.likes!.length,
                            controller: c.likesScrollController,
                            padding: const EdgeInsets.all(10),
                            itemBuilder: ((context, index) {
                              return LikePreview(
                                like: c.post.likes![index],
                                width: width,
                                height: height,
                              );
                            }),
                          ),
                        ),
                      )
                    : const SizedBox(),
                c.isDisplayingComments.value && c.post.comments!.isNotEmpty
                    ? Flexible(
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF6E9),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 3),
                          ),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: c.post.comments!.length,
                            controller: c.likesScrollController,
                            padding: const EdgeInsets.all(10),
                            itemBuilder: ((context, index) {
                              return CommentPreview(
                                comment: c.post.comments![index],
                                width: width,
                                height: height,
                              );
                            }),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
