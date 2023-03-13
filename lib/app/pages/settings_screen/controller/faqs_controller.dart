import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FAQsController extends GetxController {
  var width = Get.width;
  var height = Get.height;

  openLoginFAQ() {
    Get.defaultDialog(
      title: 'I Can\'t Log In',
      titleStyle: const TextStyle(
        fontSize: 18,
      ),
      content: Container(
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
        height: height * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '1. Username and Password Troubleshooting',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.05,
                ),
                SizedBox(
                  width: width * 0.57,
                  child: const Text(
                    'if you can’t remember your password reset it using your email address or phone number ',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            const Text(
              '2. Email Troubleshooting',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.05,
                ),
                SizedBox(
                  width: width * 0.57,
                  child: const Text(
                    'if you can’t access your email account, try to reset your password using your phone number',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  openReportFAQ() {
    Get.defaultDialog(
      title: 'How to Report a Problem',
      titleStyle: const TextStyle(
        fontSize: 18,
      ),
      content: Container(
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
        height: height * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '1. Report Post',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.05,
                ),
                SizedBox(
                  width: width * 0.57,
                  child: const Text(
                    'if you want to report a post, click on the three dots on the under the post and click on report',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            const Text(
              '2. Report User',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.05,
                ),
                SizedBox(
                  width: width * 0.57,
                  child: const Text(
                    'if you want to report a user, click on the top right corner of the user profile and click on report',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            const Text(
              '3. Report System Problem',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.05,
                ),
                SizedBox(
                  width: width * 0.57,
                  child: const Text(
                    'if you want to report a system problem, please email us at bossmancorp@protonmail.com',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  replayOnboarding() {
    Get.offAllNamed('/onboarding');
  }
}
