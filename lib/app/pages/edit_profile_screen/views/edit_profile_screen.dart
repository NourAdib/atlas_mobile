import 'dart:io';

import 'package:atlas_mobile/app/pages/edit_profile_screen/controller/edit_profile_controller.dart';
import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:atlas_mobile/app/widgets/non_filled_form_field.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EditProfileController c = Get.put(EditProfileController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.getUserProfile();
    });

    return Scaffold(
        appBar: const TopBar(pageTile: 'Edit Profile', hasBackButton: true),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(
            horizontal: c.width * 0.02,
            vertical: c.width * 0.03,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  c.goToPreviousScreen();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFFEFCB68),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                    Size(c.width * 0.46, c.height * 0.07),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: c.width * 0.03),
              ElevatedButton(
                onPressed: () async {
                  await c.updateUserProfile();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFF182335),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                    Size(c.width * 0.46, c.height * 0.07),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Obx(
            () => c.isLoading.value
                ? const LoadingIndicator()
                : SingleChildScrollView(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: Column(
                              children: [
                                SizedBox(height: c.height * 0.02),
                                InkWell(
                                  onTap: () async {
                                    await c.pickImage();
                                  },
                                  child: SizedBox(
                                      child: Obx(
                                    () => Column(
                                      children: [
                                        c.noImageSelected.value
                                            ? SvgPicture.asset(
                                                'assets/images/select_image_icon.svg',
                                                width: c.width * 0.2,
                                              )
                                            : Image.file(
                                                File(
                                                  c.imagePath.value,
                                                ),
                                                width: c.width * 0.2,
                                              ),
                                        SizedBox(height: c.height * 0.01),
                                        const Text(
                                          'Set profile picture',
                                          style: TextStyle(
                                            color: Color(0xFFEF694D),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                                ),
                                SizedBox(height: c.height * 0.1),
                                NonFilledFormField(
                                  screenWidth: c.width,
                                  controller: c.usernameTextEditingController,
                                  labelText: 'Username',
                                ),
                                SizedBox(height: c.height * 0.05),
                                NonFilledFormField(
                                  screenWidth: c.width,
                                  controller: c.bioTextEditingController,
                                  labelText: 'Bio',
                                  maxLength: 100,
                                  maxLine: 4,
                                ),
                                InkWell(
                                  onTap: () {
                                    c.goToAccountSettings();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 7,
                                      vertical: c.width * 0.05,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Account Settings',
                                          style: TextStyle(
                                            color: Color(0xFFEF694D),
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(width: c.width * 0.02),
                                        SvgPicture.asset(
                                          'assets/images/right_arrow_icon.svg',
                                          color: const Color(0xFFEF694D),
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ));
  }
}
