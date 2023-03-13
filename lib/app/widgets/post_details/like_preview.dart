import 'package:atlas_mobile/app/model/like.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../user_avatar.dart';

class LikePreview extends StatelessWidget {
  final Like like;
  final double height;
  final double width;

  const LikePreview({
    required this.like,
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  //final ProfileScreenController c = Get.find<ProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              UserAvatar(
                profilePictureUrl: like.likedBy?.profilePictureUrl ?? '',
                width: width * 0.1,
                height: height * 0.1,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(like.likedBy!.username ?? ''),
            ],
          ),
        ],
      ),
    );
  }
}
