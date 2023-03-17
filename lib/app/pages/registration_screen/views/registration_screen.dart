import 'dart:io';

import 'package:atlas_mobile/app/pages/registration_screen/controllers/registration_screen_controller.dart';
import 'package:atlas_mobile/app/widgets/non_filled_form_field.dart';
import 'package:atlas_mobile/app/widgets/page_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegistrationScreenController c =
        Get.put(RegistrationScreenController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.captchaTest();
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PageTitle(
                screenWidth: c.width,
                displayText: 'Registration',
              ),
              SizedBox(height: c.height * 0.01),
              Column(
                children: [
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
                  SizedBox(height: c.height * 0.02),
                  NonFilledFormField(
                    screenWidth: c.width,
                    controller: c.firstNameTextFieldController,
                    labelText: 'First Name',
                    hintText: 'John',
                  ),
                  SizedBox(height: c.height * 0.02),
                  NonFilledFormField(
                    screenWidth: c.width,
                    controller: c.lastNameTextFieldController,
                    labelText: 'Last Name',
                    hintText: 'Doe',
                  ),
                  SizedBox(height: c.height * 0.02),
                  NonFilledFormField(
                    screenWidth: c.width,
                    controller: c.emailTextFieldController,
                    labelText: 'Email',
                    hintText: 'johndoe@example.com',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: c.height * 0.02),
                  NonFilledFormField(
                    screenWidth: c.width,
                    controller: c.usernameTextFieldController,
                    labelText: 'Username',
                    hintText: 'JohnDoe',
                  ),
                  SizedBox(height: c.height * 0.02),
                  NonFilledFormField(
                    screenWidth: c.width,
                    controller: c.dobTextFieldController,
                    labelText: 'DOB',
                    hintText: 'yyyy-mm-dd',
                  ),
                  SizedBox(height: c.height * 0.02),
                  NonFilledFormField(
                    screenWidth: c.width,
                    controller: c.phoneNumberTextFieldController,
                    labelText: 'Phone Number',
                    hintText: '00971501234567',
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: c.height * 0.02),
                  NonFilledFormField(
                    screenWidth: c.width,
                    controller: c.addressTextFieldController,
                    labelText: 'Address (Optional)',
                    keyboardType: TextInputType.streetAddress,
                  ),
                  SizedBox(height: c.height * 0.02),
                  NonFilledFormField(
                    screenWidth: c.width,
                    controller: c.passwordTextFieldController,
                    labelText: 'Password',
                    obscureText: true,
                  ),
                  SizedBox(height: c.height * 0.02),
                  NonFilledFormField(
                    screenWidth: c.width,
                    controller: c.confirmPasswordTextFieldController,
                    labelText: 'Confirm Password',
                    obscureText: true,
                  ),
                ],
              ),
              Container(
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        await c.register();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF182335),
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(
                          Size(c.width * 0.46, c.height * 0.07),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
            ],
          ),
        ),
      ),
    );
  }
}
