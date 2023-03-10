import 'package:atlas_mobile/app/pages/settings_screen/controller/account_settings_controller.dart';
import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/non_filled_form_field.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final AccountSettingsController c = Get.put(AccountSettingsController());

    c.getUserProfile();
    c.roleList = c.getRolesList();

    return Scaffold(
      appBar: const TopBar(
        pageTile: 'Account',
        hasBackButton: true,
      ),
      body: SafeArea(
          child: Obx(
        () => c.isLoading.value
            ? const LoadingIndicator()
            : Column(
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
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(height: c.height * 0.02),
                          NonFilledFormField(
                            screenWidth: c.width,
                            controller: c.emailTextEditingController,
                            keyboardType: TextInputType.emailAddress,
                            labelText: 'Email',
                          ),
                          SizedBox(height: c.height * 0.02),
                          NonFilledFormField(
                            screenWidth: c.width,
                            controller: c.dobTextEditingController,
                            keyboardType: TextInputType.datetime,
                            labelText: 'Date of Birth',
                          ),
                          SizedBox(height: c.height * 0.02),
                          Container(
                            width: c.width * 0.8,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD9D9D9),
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
                                  offset: Offset(
                                      0, 4), // changes position of shadow
                                )
                              ],
                            ),
                            child: DropdownButton(
                                icon: const Icon(Icons.edit_outlined),
                                value: c.gender.value,
                                isExpanded: true,
                                items: c.genderList.map((e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  c.gender.value = newValue!;
                                }),
                          ),
                          SizedBox(height: c.height * 0.02),
                          Container(
                            width: c.width * 0.8,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD9D9D9),
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
                                  offset: Offset(
                                      0, 4), // changes position of shadow
                                )
                              ],
                            ),
                            child: DropdownButton(
                                icon: const Icon(Icons.edit_outlined),
                                value: c.role.value,
                                isExpanded: true,
                                items: c.roleList.map((e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  c.role.value = newValue!;
                                }),
                          ),
                          SizedBox(height: c.height * 0.04),
                          SizedBox(
                            width: c.width * 0.7,
                            child: ElevatedButton(
                              onPressed: () async {
                                await c.deleteAccount();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  const Color(0xFF000000),
                                ),
                                minimumSize: MaterialStateProperty.all<Size>(
                                  Size(c.width * 0.46, c.height * 0.07),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Delete Account',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    'assets/images/right_arrow_icon.svg',
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
      )),
    );
  }
}
