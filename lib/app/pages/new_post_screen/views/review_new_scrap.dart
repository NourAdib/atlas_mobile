import 'package:atlas_mobile/app/pages/new_post_screen/controller/new_post_controller.dart';
import 'package:atlas_mobile/app/widgets/non_filled_form_field.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../controller/review_new_scrap_controller.dart';

class ReviewScrap extends StatelessWidget {
  const ReviewScrap({super.key});

  @override
  Widget build(BuildContext context) {
    final NewPostController c = Get.put(NewPostController());
    return Scaffold(
      appBar: const TopBar(pageTile: 'New Scrap'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.04),
              NonFilledFormField(
                  screenWidth: Get.width,
                  controller: c.captionTextFieldController,
                  labelText: "Caption"),
              SizedBox(height: Get.height * 0.04),
              NonFilledFormField(
                  screenWidth: Get.width,
                  controller: c.locationTextFieldController,
                  labelText: "Location"),
              SizedBox(height: Get.height * 0.04),
              Column(
                children: [
                  const Text("Tag"),
                  SizedBox(height: Get.height * 0.009),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Obx(
                        () => InkWell(
                          onTap: () {
                            c.choosePersonal();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: Get.width * 0.232,
                            height: Get.height * 0.053,
                            decoration: BoxDecoration(
                                color: c.personal.value
                                    ? const Color(0xffEFCB68)
                                    : const Color(0xffFFF6E9),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: c.personal.value
                                    ? const [
                                        BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 2.5)
                                      ]
                                    : const [
                                        BoxShadow(
                                            color: Colors.black, blurRadius: 1)
                                      ]),
                            child: const Text("Personal"),
                          ),
                        ),
                      ),
                      Obx(
                        () => InkWell(
                          onTap: () {
                            c.chooseOpinion();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: Get.width * 0.232,
                            height: Get.height * 0.053,
                            decoration: BoxDecoration(
                                color: c.opinion.value
                                    ? const Color(0xffEFCB68)
                                    : const Color(0xffFFF6E9),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: c.opinion.value
                                    ? const [
                                        BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 2.5)
                                      ]
                                    : const [
                                        BoxShadow(
                                            color: Colors.black, blurRadius: 1)
                                      ]),
                            child: const Text("Opinion"),
                          ),
                        ),
                      ),
                      Obx(
                        () => InkWell(
                          onTap: () {
                            c.chooseFact();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: Get.width * 0.232,
                            height: Get.height * 0.053,
                            decoration: BoxDecoration(
                                color: c.fact.value
                                    ? const Color(0xffEFCB68)
                                    : const Color(0xffFFF6E9),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: c.fact.value
                                    ? const [
                                        BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 2.5)
                                      ]
                                    : const [
                                        BoxShadow(
                                            color: Colors.black, blurRadius: 1)
                                      ]),
                            child: const Text("Fact"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
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
              SizedBox(height: Get.height * 0.329),
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
                      onPressed: () async {
                        c.createScrap();
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
