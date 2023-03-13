import 'package:atlas_mobile/app/pages/new_post_screen/controller/review_new_scrapbook_controller.dart';
import 'package:atlas_mobile/app/pages/new_post_screen/views/review_new_scrap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/non_filled_form_field.dart';
import '../../../widgets/topBar/topbar.dart';

class ReviewScarpbook extends StatelessWidget {
  const ReviewScarpbook({super.key});

  @override
  Widget build(BuildContext context) {
    final ReviewNewScrapbookController c =
        Get.put(ReviewNewScrapbookController());
    return Scaffold(
      appBar: const TopBar(pageTile: 'New Scrapbook'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.04),
              NonFilledFormField(
                  screenWidth: Get.width,
                  controller: c.peopleTextFieldController,
                  labelText: "Name"),
              SizedBox(height: Get.height * 0.04),
              NonFilledFormField(
                  screenWidth: Get.width,
                  controller: c.locationTextFieldController,
                  labelText: "Description"),
              SizedBox(height: Get.height * 0.04),
              NonFilledFormField(
                  screenWidth: Get.width,
                  controller: c.peopleTextFieldController,
                  labelText: "Location"),
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
                                            color: Colors.black, blurRadius: 1)
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
                                            color: Colors.black, blurRadius: 1)
                                      ]),
                            child: const Text("Private"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.339),
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
                        c.goToPrreviousScreen();
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
                      onPressed: () async {},
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
