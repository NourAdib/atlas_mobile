import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
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
          Container(
            width: Get.width * 0.228,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("@user"),
                CircleAvatar(
                  radius: Get.height * 0.042,
                  backgroundColor: Colors.black,
                ),
                Container(
                  height: Get.height * 0.026,
                  width: Get.width * 0.186,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xffEFCB68)),
                )
              ],
            ),
          ),
          Container(
            width: Get.width * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text("name"),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text('999M'),
                            const Text("followers"),
                          ],
                        ),
                        Column(
                          children: [
                            Text('999M'),
                            const Text("following"),
                          ],
                        ),
                      ],
                    ),
                    const Text("Bio"),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Align(
              alignment: Alignment.topRight,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xffEF694D),
                    radius: Get.height * 0.025,
                    child: SvgPicture.asset(
                        width: Get.width * 0.09, 'assets/images/edit_icon.svg'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
