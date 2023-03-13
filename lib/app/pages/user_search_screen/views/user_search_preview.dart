import 'package:atlas_mobile/app/model/user.model.dart';
import 'package:atlas_mobile/app/pages/user_search_screen/controller/user_search_controller.dart';
import 'package:atlas_mobile/app/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class UserSearchPreview extends StatelessWidget {
  final User user;

  UserSearchPreview({super.key, required this.user});

  final UserSearchScreenController c = Get.put(UserSearchScreenController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => c.navigateToUser(user),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF6E9),
          border: Border.all(
            color: const Color(0xFF182335),
            width: 3,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 4,
              offset: Offset(0, 4), // changes position of shadow
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                UserAvatar(
                  height: Get.height * 0.05,
                  width: Get.height * 0.05,
                  profilePictureUrl: user.profilePictureUrl ?? '',
                  minRadius: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  user.username ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SvgPicture.asset('assets/images/right_arrow_icon.svg')
          ],
        ),
      ),
    );
  }
}
