import 'package:atlas_mobile/app/pages/new_post_screen/controller/new_post_controller.dart';
import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:atlas_mobile/app/widgets/non_filled_form_field.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/review_new_memory_controller.dart';

class ReviewEvent extends StatelessWidget {
  const ReviewEvent({super.key});

  @override
  Widget build(BuildContext context) {
    final NewPostController c = Get.put(NewPostController());
    return Scaffold(
      appBar: const TopBar(
        pageTile: 'Treasure Hunt',
        hasBackButton: true,
      ),
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
                c.goToPrreviousScreen();
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
                c.createEventRequest();
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
                child: Column(
                  children: [
                    SizedBox(height: Get.height * 0.04),
                    NonFilledFormField(
                        screenWidth: Get.width,
                        controller: c.eventNameTextFieldController,
                        labelText: "Event Name"),
                    SizedBox(height: Get.height * 0.04),
                    NonFilledFormField(
                        keyboardType: TextInputType.number,
                        screenWidth: Get.width,
                        controller: c.participantsTextFieldController,
                        hintText: "maximum 100",
                        labelText: "Number of Participants"),
                    SizedBox(height: Get.height * 0.04),
                    NonFilledFormField(
                        screenWidth: Get.width,
                        controller: c.descriptionTextFieldController,
                        labelText: "Description"),
                    SizedBox(height: Get.height * 0.04),
                    NonFilledFormField(
                      screenWidth: c.width,
                      controller: c.dateTextFieldController,
                      labelText: 'Date of Event',
                      hintText: 'yyyy-mm-dd',
                    ),
                    SizedBox(height: Get.height * 0.04),
                    Column(
                      children: [
                        const Text("Visibility"),
                        SizedBox(height: Get.height * 0.009),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Obx(
                              () => InkWell(
                                onTap: () {
                                  c.choosePublic();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: Get.width * 0.232,
                                  height: Get.height * 0.053,
                                  decoration: BoxDecoration(
                                      color: c.public.value
                                          ? const Color(0xffEFCB68)
                                          : const Color(0xffFFF6E9),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: c.public.value
                                          ? const [
                                              BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 2.5)
                                            ]
                                          : const [
                                              BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 1)
                                            ]),
                                  child: const Text("Public"),
                                ),
                              ),
                            ),
                            Obx(
                              () => InkWell(
                                onTap: () {
                                  c.choosePrivate();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: Get.width * 0.232,
                                  height: Get.height * 0.053,
                                  decoration: BoxDecoration(
                                      color: c.private.value
                                          ? const Color(0xffEFCB68)
                                          : const Color(0xffFFF6E9),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: c.private.value
                                          ? const [
                                              BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 2.5)
                                            ]
                                          : const [
                                              BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 1)
                                            ]),
                                  child: const Text("Private"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.04),
                    InkWell(
                      onTap: () => c.setGoal(),
                      child: Container(
                        alignment: Alignment.center,
                        width: Get.width * 0.8,
                        height: Get.height * 0.053,
                        decoration: BoxDecoration(
                          color: const Color(0xffFFF6E9),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(color: Colors.black, blurRadius: 1)
                          ],
                        ),
                        child: Text(
                          c.isGoalSet.value ? "Goal Set" : "Set Goal",
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    InkWell(
                      onTap: () => c.setClues(),
                      child: Container(
                        alignment: Alignment.center,
                        width: Get.width * 0.8,
                        height: Get.height * 0.053,
                        decoration: BoxDecoration(
                          color: const Color(0xffFFF6E9),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(color: Colors.black, blurRadius: 1)
                          ],
                        ),
                        child: Text(
                          c.hasClues.value
                              ? "${c.clues.length} Clues Set"
                              : "Set Clues",
                        ),
                      ),
                    ),
                    Container(
                      width: c.width * 0.8,
                      margin: EdgeInsets.symmetric(
                        vertical: Get.height * 0.02,
                        horizontal: Get.width * 0.1,
                      ),
                      child: const Text(
                        'Adding a goal or clue will set it to your current location',
                      ),
                    ),
                  ],
                ),
              ),
      )),
    );
  }
}
