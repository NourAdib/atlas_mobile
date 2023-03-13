import 'package:atlas_mobile/app/model/comment.model.dart';
import 'package:atlas_mobile/app/model/like.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../user_avatar.dart';

class CommentPreview extends StatelessWidget {
  final Comment comment;
  final double height;
  final double width;

  const CommentPreview({
    required this.comment,
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  //final ProfileScreenController c = Get.find<ProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: SizedBox(
              width: width * 0.6,
              child: Text(
                comment.text ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              UserAvatar(
                profilePictureUrl: comment.author?.profilePictureUrl ?? '',
                width: width * 0.1,
                height: height * 0.1,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(comment.author!.username ?? ''),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
