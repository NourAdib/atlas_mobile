import 'package:atlas_mobile/app/pages/settings_screen/controller/security_controller.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/non_filled_form_field.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SecurityController c = Get.put(SecurityController());

    return Scaffold(
      appBar: const TopBar(
        pageTile: 'Security',
        hasBackButton: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      blurRadius: 4,
                      offset: Offset(0, 4), // changes position of shadow
                    )
                  ],
                ),
                width: c.width,
                child: Column(
                  children: [
                    SizedBox(height: c.height * 0.02),
                    NonFilledFormField(
                      screenWidth: c.width,
                      controller: c.currentPasswordController,
                      obscureText: true,
                      labelText: 'Current Password',
                    ),
                    SizedBox(height: c.height * 0.02),
                    NonFilledFormField(
                      screenWidth: c.width,
                      controller: c.newPasswordController,
                      obscureText: true,
                      labelText: 'New Password',
                    ),
                    SizedBox(height: c.height * 0.02),
                    NonFilledFormField(
                      screenWidth: c.width,
                      controller: c.confirmPasswordController,
                      obscureText: true,
                      labelText: 'Confirm New Password',
                    ),
                  ],
                ),
              ),
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
                      await c.changePassword();
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
          ],
        ),
      ),
    );
  }
}
