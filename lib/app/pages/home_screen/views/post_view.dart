import 'dart:developer';

import 'package:atlas_mobile/app/model/post.model.dart';
import 'package:atlas_mobile/app/pages/home_screen/controller/home_screen_controller.dart';
import 'package:atlas_mobile/app/widgets/post_details/post_details.dart';
import 'package:atlas_mobile/app/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'post_image.dart';

class PostView extends StatelessWidget {
  final Post post;
  PostView({required this.post, Key? key}) : super(key: key);

  final HomeScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() =>
            PostDetailsScreen(post: post, height: c.height, width: c.width));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
            PostImage(
              imageUrl: post.imageUrl!,
              caption: post.caption!,
              height: c.height * 0.4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    UserAvatar(
                      profilePictureUrl: post.postedBy?.profilePictureUrl ?? '',
                      width: c.width * 0.1,
                      height: c.height * 0.1,
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
          ],
        ),
      ),
    );
  }
}
