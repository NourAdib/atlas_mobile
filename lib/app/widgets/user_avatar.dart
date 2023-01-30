import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserAvatar extends StatelessWidget {
  final String profilePuictureUrl;
  final double height;
  final double width;
  const UserAvatar(
      {required this.profilePuictureUrl,
      required this.width,
      required this.height,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return profilePuictureUrl.isNotEmpty
        ? CircleAvatar(
            backgroundImage: NetworkImage(
              profilePuictureUrl,
            ),
          )
        : Container(
            width: width,
            height: height,
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: Color(0xFF182335),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/images/user_profile_icon.svg',
              color: Colors.white,
            ),
          );
  }
}
