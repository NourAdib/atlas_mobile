import 'package:atlas_mobile/app/model/post.model.dart';
import 'package:atlas_mobile/app/widgets/post_details/post_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/profile_screen_controller.dart';
import 'post_image.dart';

class PostPreview extends StatelessWidget {
  final Post post;
  PostPreview({
    required this.post,
    Key? key,
  }) : super(key: key);

  final ProfileScreenController c = Get.put(ProfileScreenController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        c.openPostDetails(post.id!);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF6E9),
          border: Border.all(
            color: const Color(0xFF182335),
            width: 3,
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
        child: PostImage(
          imageUrl: post.imageUrl!,
          caption: post.caption!,
          height: c.height,
        ),
      ),
    );
  }
}
